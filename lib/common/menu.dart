import 'package:flutter/material.dart';
import 'package:e_hujjat/common/menu_button.dart';
import 'package:e_hujjat/common/style/app_colors.dart';

class UniversalMenu extends StatelessWidget {
  const UniversalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      width: 249,
      height: 630,
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Dashboard',
            svgname: 'dashboard',
          ),
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Bo\'limlar',
            svgname: 'bolimlar',
          ),
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Foydalanuvchilar',
            svgname: 'users',
          ),
          Spacer(),
          AdminMenuButton(
            name: 'Chiqish',
            svgname: 'exit',
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
