import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepOne extends StatefulWidget {
  final VoidCallback onNext;
  const StepOne({super.key, required this.onNext});

  @override
  State<StepOne> createState() => _NazoratVaraqasiQoshishState();
}

List<Map<String, dynamic>> departments = [];
List<int> selectedDepartments = [];
List<Map<String, dynamic>> responsiblePersons = [];
List<Map<String, dynamic>> subordinates = [];
List<int> selectedSubordinates = [];

class _NazoratVaraqasiQoshishState extends State<StepOne> {
  Future<void> getDepartments() async {
    try {
      final response = await requestHelper
          .getWithAuth('/api/references/get-departments', log: true);
      setState(() {
        departments = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {}
  }

  Future<void> getResponsiblePersons() async {
    if (selectedDepartments.isEmpty) return;
    try {
      final response = await requestHelper.getWithAuth(
          '/api/controls/get-responsible-person/${selectedDepartments.join(",")}',
          log: true);
      setState(() {
        responsiblePersons = List<Map<String, dynamic>>.from(response);
        if (responsiblePersons.isNotEmpty) {
          getSubordinates();
        }
      });
    } catch (e) {}
  }

  Future<void> getSubordinates() async {
    if (responsiblePersons.isEmpty) return;
    try {
      final ids = responsiblePersons.map((person) => person['id']).join(",");
      final response = await requestHelper.getWithAuth(
          '/api/controls/get-responsible-execution/$ids',
          log: true);
      setState(() {
        subordinates = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getDepartments();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Flexible(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: themeProvider.getColor('foreground'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mas’ullar haqida ma’lumot',
                style: themeProvider.getTextStyle().copyWith(
                    color: themeProvider.getColor('icon'),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Nazorat varaqasi uchun Qo’riqlash bosh boshqarma boshlig’ining o’rinbosarlarni mas’ul qilib belgilab berasiz.',
                style: themeProvider.getTextStyle().copyWith(
                      color: themeProvider.getColor('icon'),
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<int>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: departments.map((department) {
                  return DropdownMenuItem<int>(
                    value: department['id'],
                    child: Text(department['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null && !selectedDepartments.contains(value)) {
                    setState(() {
                      selectedDepartments.add(value);
                    });
                    getResponsiblePersons();
                  }
                },
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: selectedDepartments.map((id) {
                  final department =
                      departments.firstWhere((dep) => dep['id'] == id);
                  return Chip(
                    label: Text(department['name']),
                    onDeleted: () {
                      setState(() {
                        selectedDepartments.remove(id);
                      });
                      getResponsiblePersons();
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              if (responsiblePersons.isNotEmpty) ...[
                Text(
                  'Mas’ul shaxslar:',
                  style: themeProvider.getTextStyle().copyWith(
                      color: themeProvider.getColor('icon'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: responsiblePersons.map((person) {
                    return Text(
                      person['name'],
                      style: themeProvider.getTextStyle().copyWith(
                            color: themeProvider.getColor('icon'),
                          ),
                    );
                  }).toList(),
                ),
              ],
              SizedBox(
                height: 20,
              ),
              if (subordinates.isNotEmpty) ...[
                Text(
                  'Ijrochilar:',
                  style: themeProvider.getTextStyle().copyWith(
                      color: themeProvider.getColor('icon'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: subordinates.map((subordinate) {
                    final isSelected =
                        selectedSubordinates.contains(subordinate['id']);
                    return FilterChip(
                      label: Text(subordinate['name']),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedSubordinates.add(subordinate['id']);
                          } else {
                            selectedSubordinates.remove(subordinate['id']);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        widget.onNext();
                      },
                      child: SizedBox(
                        width: 190,
                        child: Row(
                          children: [
                            Text('Nazorat haqida ma’lumot'),
                            Icon(Icons.arrow_right_alt),
                          ],
                        ),
                      )),
                ),
              ]
            ],
          ),
        ));
  }
}
