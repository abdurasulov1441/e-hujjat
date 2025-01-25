import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NazoratVaraqasiQoshish extends StatefulWidget {
  const NazoratVaraqasiQoshish({Key? key}) : super(key: key);

  @override
  _NazoratVaraqasiQoshishState createState() => _NazoratVaraqasiQoshishState();
}

class _NazoratVaraqasiQoshishState extends State<NazoratVaraqasiQoshish> {
  List<dynamic> departments = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    const url = 'http://10.100.26.2:5000/api/references/get-departments';
    const token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsInVzZXJuYW1lIjoibXVuaXNhIiwicm9sZV9pZCI6MiwiaWF0IjoxNzM3ODA1Mjk2LCJleHAiOjE3Mzc4MTYwOTZ9.rZsRsZ44ZcIl65jlUsoZmURVvDlR3Cl0zSbQCIhbI7I';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          departments = json.decode(response.body);
        });
      } else {
        print('Failed to load departments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left-side navigation steps
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _StepIndicator(
                      isActive: true,
                      label: 'Mas’ullar haqida ma’lumot',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    _StepIndicator(
                      isActive: false,
                      label: 'Nazorat haqida ma’lumot',
                      icon: Icons.article,
                    ),
                    SizedBox(height: 20),
                    _StepIndicator(
                      isActive: false,
                      label: 'Mazmuni haqida ma’lumot',
                      icon: Icons.description,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right-side form
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mas’ullar haqida ma’lumot',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Nazorat varaqasi uchun Qo‘riqlash bosh boshqarma boshlig‘ining o‘rinbosarlarini mas’ul qilib belgilab berasiz.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    // Multi-select for Bo‘limlar
                    const Text(
                      'Bo‘limlar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MultiSelectDialogField(
                      items: departments
                          .map((e) => MultiSelectItem(e['id'], e['name']))
                          .toList(),
                      title: const Text('Bo‘limlar'),
                      onConfirm: (values) {},
                      buttonText: const Text('Bo‘limlarni tanlang'),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Spacer(),
                    // Next button
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Nazorat haqida ma’lumot'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final bool isActive;
  final String label;
  final IconData icon;

  const _StepIndicator({
    Key? key,
    required this.isActive,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: isActive ? Colors.red : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.red : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
