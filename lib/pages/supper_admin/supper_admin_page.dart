import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/common/diagram.dart';
import 'package:e_hujjat/common/menu.dart';
import 'package:e_hujjat/common/statistic.dart';
import 'package:e_hujjat/common/style/app_colors.dart';
import 'package:flutter/material.dart';

class SupperAdminPage extends StatelessWidget {
  const SupperAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              MyCustomAppBar(),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          UniversalMenu(),
                        ],
                      ),
                      Column(
                        children: [
                          AdminStatistic(),
                          Row(
                            children: [
                              Diagram(),
                              Calendar(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
