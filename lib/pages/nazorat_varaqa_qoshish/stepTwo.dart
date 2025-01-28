import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/step_two_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepTwo extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const StepTwo({Key? key, required this.onNext, required this.onPrevious})
      : super(key: key);

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  List<Map<String, dynamic>> docTypes = [];
  int? selectedDocTypeId1;
  int? selectedDocTypeId2;
  final TextEditingController _documentNumberController =
      TextEditingController();
  final TextEditingController _documentNameController = TextEditingController();
  final TextEditingController _taskDeadlineController = TextEditingController();
  final TextEditingController _acceptanceDateController =
      TextEditingController();
  final TextEditingController _assignmentTimeController =
      TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _docNumberController = TextEditingController();

  Future<void> _getDocTypes() async {
    try {
      final response = await requestHelper.getWithAuth(
        '/api/references/get-doc-types',
        log: true,
      );
      setState(() {
        docTypes = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error fetching document types: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getDocTypes();
  }

  @override
  Widget build(BuildContext context) {
    final stepTwoProvider = Provider.of<StepTwoProvider>(context);
    return Container(
      color: Color(0xFFFFF5F5),
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nazorat haqida ma’lumot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nazorat varaqasining raqamini qaysi turga kirishini va uning berilgan sanasi hamda ijro etish kerak bo’lgan sanalarini kiritiladi',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) =>
                  stepTwoProvider.updateField('nazoratVaraqasiRaqami', value),
              controller: _documentNumberController,
              decoration: InputDecoration(
                labelText: 'Hujjat raqami',
                prefixIcon:
                    const Icon(Icons.document_scanner, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: (value) =>
                  stepTwoProvider.updateField('hujjatNomi', value),
              controller: _documentNameController,
              decoration: InputDecoration(
                labelText: 'Nomlanishi',
                prefixIcon: const Icon(Icons.text_fields, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) =>
                        stepTwoProvider.updateField('hujjatRaqami', value),
                    controller: _docNumberController,
                    decoration: InputDecoration(
                      labelText: 'Hujjat raqami',
                      prefixIcon:
                          const Icon(Icons.receipt_long, color: Colors.brown),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    isExpanded: true,
                    value: selectedDocTypeId1,
                    decoration: InputDecoration(
                      labelText: 'Hujjat turi',
                      prefixIcon: const Icon(Icons.list, color: Colors.brown),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: docTypes.map((docType) {
                      return DropdownMenuItem<int>(
                        value: docType['id'],
                        child: Text(docType['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDocTypeId1 = value;
                        stepTwoProvider.updateField('docTypeId1', value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _assignmentTimeController,
              decoration: InputDecoration(
                labelText: 'Topshiriq vaqti',
                prefixIcon:
                    const Icon(Icons.calendar_today, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _assignmentTimeController.text =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    stepTwoProvider.updateField(
                        'topshiriqVaqti', _assignmentTimeController.text);
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => stepTwoProvider.updateField(
                        'royxatgaOlishRaqami', value),
                    controller: _registrationNumberController,
                    decoration: InputDecoration(
                      labelText: 'Hujjat ro’yxatga olish raqami',
                      prefixIcon:
                          const Icon(Icons.receipt, color: Colors.brown),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    isExpanded: true,
                    value: stepTwoProvider.docTypeId1,
                    decoration: InputDecoration(
                      labelText: 'Hujjat turi',
                      prefixIcon: const Icon(Icons.list, color: Colors.brown),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: docTypes.map((docType) {
                      return DropdownMenuItem<int>(
                        value: docType['id'],
                        child: Text(docType['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDocTypeId2 = value;
                        stepTwoProvider.updateField('docTypeId2', value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _acceptanceDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Qabul qilingan sana',
                prefixIcon: const Icon(Icons.date_range, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _acceptanceDateController.text =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    stepTwoProvider.updateField(
                        'qabulQilinganVaqti', _acceptanceDateController.text);
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: (value) =>
                  stepTwoProvider.updateField('ijroMuddati', value),
              controller: _taskDeadlineController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Ijro muddati',
                prefixIcon: const Icon(Icons.schedule, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _taskDeadlineController.text =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    stepTwoProvider.updateField(
                        'ijroMuddati', _taskDeadlineController.text);
                  });
                }
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: widget.onPrevious,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 5),
                      Text('Mas’ullar haqida ma’lumot'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    children: const [
                      Text('Mazmuni haqida ma’lumot'),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
