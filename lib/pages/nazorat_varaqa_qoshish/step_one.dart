import 'package:flutter/material.dart';

class StepOne extends StatelessWidget {
  final VoidCallback onNext;

  const StepOne({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mas’ullar haqida ma’lumot',
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            items: [
              DropdownMenuItem(value: 'option1', child: Text('Option 1')),
              DropdownMenuItem(value: 'option2', child: Text('Option 2')),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: 'Bo’limlar',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNext,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Keyingi'),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
