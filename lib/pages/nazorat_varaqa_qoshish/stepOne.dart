import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/card_provider.dart';
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
  
    return Flexible(
        flex: 2,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color(0XFFFFF5F5)),
          child: Container(
            decoration: BoxDecoration(
              // color: themeProvider.getColor('foreground'),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mas’ullar haqida ma’lumot',
                  // style: themeProvider.getTextStyle().copyWith(
                  //     color: themeProvider.getColor('icon'),
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Nazorat varaqasi uchun Qo’riqlash bosh boshqarma boshlig’ining o’rinbosarlarni mas’ul qilib belgilab berasiz.',
                  // style: themeProvider.getTextStyle().copyWith(
                  //       color: themeProvider.getColor('icon'),
                  //     ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<int>(
                  // dropdownColor: themeProvider.getColor('foreground'),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  isExpanded: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: departments.map((department) {
                    return DropdownMenuItem<int>(
                      value: department['id'],
                      child: Text(
                        department['name'],
                        // style: themeProvider.getTextStyle().copyWith()
                      ),
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
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: selectedDepartments.map((id) {
                    final department =
                        departments.firstWhere((dep) => dep['id'] == id);
                    return Chip(
                      // deleteIconColor: themeProvider.getColor('icon'),
                      // backgroundColor: themeProvider.getColor('background'),
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
                    // style: themeProvider.getTextStyle().copyWith(
                    //     color: themeProvider.getColor('icon'),
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: responsiblePersons.map((person) {
                      return Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            person['name'],
                            // style: themeProvider.getTextStyle().copyWith(
                            //       color: themeProvider.getColor('icon'),
                            //     ),
                          ),
                        ],
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
                    // style: themeProvider.getTextStyle().copyWith(
                    //     color: themeProvider.getColor('icon'),
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold),
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
                        // checkmarkColor: isSelected
                        //     ? themeProvider.getColor('background')
                        //     : themeProvider.getColor('icon'),
                        // selectedColor: isSelected
                        //     ? themeProvider.getColor('icon')
                        //     : Colors.green,
                        // backgroundColor: themeProvider.getColor('background'),
                        label: Text(
                          subordinate['name'],
                          // style: themeProvider.getTextStyle().copyWith(
                          //     color: isSelected
                          //         ? themeProvider.getColor('foreground')
                          //         : themeProvider.getColor('text')),
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            final selectedData = {
                              'departments': selectedDepartments,
                              'responsiblePersons': responsiblePersons
                                  .map((p) => p['id'])
                                  .toList(),
                              'subordinates': selectedSubordinates,
                            };
                            Provider.of<ControlCardProvider>(context,
                                    listen: false)
                                .updateSelectedData(selectedData);
                            widget.onNext();
                          },
                          child: SizedBox(
                            width: 230,
                            height: 40,
                            child: Row(
                              children: [
                                Text(
                                  'Nazorat haqida ma’lumot',
                                  // style: themeProvider.getTextStyle(),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  // color: themeProvider.getColor('icon'),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ));
  }
}
