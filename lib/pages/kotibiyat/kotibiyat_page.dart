import 'package:flutter/material.dart';
import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/menu.dart';
import 'package:e_hujjat/common/style/app_colors.dart';

class KotibiyatPage extends StatelessWidget {
  const KotibiyatPage({super.key});

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
                          
                          UniversalMenu()],
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
