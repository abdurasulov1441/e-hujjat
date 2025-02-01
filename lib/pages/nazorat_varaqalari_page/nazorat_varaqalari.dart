import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NazoratVaraqalari extends StatefulWidget {
  const NazoratVaraqalari({Key? key}) : super(key: key);

  @override
  _NazoratVaraqalariState createState() => _NazoratVaraqalariState();
}

class _NazoratVaraqalariState extends State<NazoratVaraqalari> {
  List<Map<String, dynamic>> controlCards = [];
  List<Map<String, dynamic>> departments = [];
  List<Map<String, dynamic>> subordinates = [];
  int? selectedDepartmentId;
  int? selectedSubordinateId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDepartments();
    _fetchControlCard();
  }

  Future<void> getDepartments() async {
    try {
      final response = await requestHelper
          .getWithAuth('/api/references/get-departments', log: true);
      setState(() {
        departments = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print("Error fetching departments: $e");
    }
  }

  Future<void> getSubordinates(int departmentId) async {
    try {
      final response = await requestHelper.getWithAuth(
          '/api/controls/get-responsible-execution/$departmentId',
          log: true);
      setState(() {
        subordinates = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print("Error fetching subordinates: $e");
    }
  }

  Future<void> _fetchControlCard() async {
    try {
      final response = await requestHelper.getWithAuth(
        '/api/controls/get-control/${selectedDepartmentId ?? 4}/0/${selectedSubordinateId ?? 6}',
        log: true,
      );
      setState(() {
        controlCards = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching control cards: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: themeProvider.getColor('background'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    value: selectedDepartmentId,
                    hint: const Text('Bo\'limni tanlang'),
                    items: departments.map((dept) {
                      return DropdownMenuItem<int>(
                        value: dept['id'],
                        child: Text(dept['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDepartmentId = value;
                        selectedSubordinateId = null;
                        subordinates = [];
                        print(selectedDepartmentId);
                      });
                      if (value != null) {
                        getSubordinates(value);
                        _fetchControlCard();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<int>(
                    value: selectedSubordinateId,
                    hint: const Text('Xodimni tanlang'),
                    items: subordinates.map((person) {
                      return DropdownMenuItem<int>(
                        value: person['id'],
                        child: Text(person['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubordinateId = value;
                        print(selectedSubordinateId);
                      });
                      _fetchControlCard();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<PageProvider>(context, listen: false)
                        .updatePageByRoute('nazoratVaraqasiQoshishPage');
                  },
                  child: const Text('Nazorat varaqasi qo\'shish'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: controlCards.length,
                      itemBuilder: (context, index) {
                        final card = controlCards[index];
                        return _buildNewCard(card);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNewCard(Map<String, dynamic> card) {
  return Container(
    width: 400,
    height: 400,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${card['id']}',
                ),
                Row(
                  children: [
                    Image.asset('assets/images/edit.png', width: 30),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/images/view.svg'),
                    Column(
                      children: [
                        Text(
                          'Hujjatni',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text('ko\'rish', style: TextStyle(fontSize: 10))
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: card['rest_date'] < 5
                            ? Colors.red
                            : Color(0xFF009DAE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${card['rest_date']}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF007AFF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${card["status"]}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Ijro uchun mas’ul: ${card["responsible_person"]}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              'Ijrochilar:  ${card["responsible_execution"]}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              'Hujjatning nomlanishi: ${card["naming"]}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              'Topshiriq vaqti: ${card["assignment_time"]}',
            ),
            const SizedBox(height: 5),
            Text(
              'Ijro muddati: ${card["deadline"]}',
            ),
            const SizedBox(height: 5),
            Text(
              'Mazmuni: ${card["info_text"]}',
              style: TextStyle(fontSize: 12),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}
