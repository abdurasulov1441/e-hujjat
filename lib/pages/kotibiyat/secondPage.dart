import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/common/diagram.dart';
import 'package:e_hujjat/common/statistic.dart';
import 'package:flutter/material.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminStatistic(),
        Row(
          children: [
            Diagram(),
            Calendar(),
          ],
        ),
      ],
    );
  }
}
