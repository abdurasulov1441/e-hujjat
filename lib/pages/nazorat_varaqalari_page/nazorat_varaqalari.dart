import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NazoratVaraqalari extends StatefulWidget {
  const NazoratVaraqalari({Key? key}) : super(key: key);

  @override
  _NazoratVaraqalariState createState() => _NazoratVaraqalariState();
}

class _NazoratVaraqalariState extends State<NazoratVaraqalari> {
  List<Map<String, dynamic>> controlCards = []; // Список карточек
  bool isLoading = true; // Флаг загрузки

  Future<void> _fetchControlCard() async {
    try {
      final response = await requestHelper.getWithAuth(
        '/api/controls/get-control/0/0/0',
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
  void initState() {
    super.initState();
    _fetchControlCard();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.getColor('background'),
   
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search and Filter Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Qidiring',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(
                        value: 'Barchasi', child: Text('Barchasi')),
                    DropdownMenuItem(value: 'Yangi', child: Text('Yangi')),
                    DropdownMenuItem(
                        value: 'Qabul qilingan', child: Text('Qabul qilingan')),
                  ],
                  onChanged: (value) {},
                  hint: const Text('Filtrlash'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .updatePageByRoute('nazoratVaraqasiQoshishPage');
                  },
                  child: const Text('Nazorat varaqasi qo\'shish'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Content Area
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

  Widget _buildNewCard(Map<String, dynamic> card) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Card(
        // color: Colors.white,
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
                          color: Color(0xFF009DAE),
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
                'Hujjatning nomlanishi: Qomondonning buyruq #2025',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                'Topshiriq vaqti: 01.04.2025',
              ),
              const SizedBox(height: 5),
              Text(
                'Ijro muddati: 01.04.2025',
              ),
              const SizedBox(height: 5),
              Text(
                'Mazmuni: lkjhafkldj;hsdksdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdklsdkjfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdkljfhksajldhflkjashdkljfghkljsdfhgkljsdfblkgjvbnzxlckjgkljhsdkljfhkljasdhflkjhskjldfhka;wjheskjlfhlskjehdfkjszdhkfjSKJLd',
                style: TextStyle(fontSize: 12),
                maxLines: 4, // Максимальное количество строк
                overflow: TextOverflow.ellipsis, // Установка троеточия
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
