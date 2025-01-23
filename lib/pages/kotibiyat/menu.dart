import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/pages/kotibiyat/menu_button.dart';
import 'package:e_hujjat/common/style/app_colors.dart';

class UniversalMenu extends StatelessWidget {
  const UniversalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      try {
        final response =
            await requestHelper.postWithAuth('/api/auth/logout', {}, log: true);
        print(response);
      } catch (error) {
        ElegantNotification.success(
          width: 360,
          isDismissable: false,
          animationCurve: Curves.easeInOut,
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          description: Text('Akkauntdan chiqildi'),
          onDismiss: () {},
          onNotificationPressed: () {},
          shadow: BoxShadow(
            color: Colors.green,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ).show(context);
      }
      cache.clear();
      router.go(Routes.loginPage);
    }

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      width: 249,
      height: 630,
      decoration: BoxDecoration(
        color: AppColors.foregroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Dashboard',
            svgname: 'dashboard',
            onPressed: () {
              print('Dashboard bosildi');
            },
          ),
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Bo\'limlar',
            svgname: 'bolimlar',
            onPressed: () {
              print('Bo\'limlar bosildi');
            },
          ),
          SizedBox(
            height: 10,
          ),
          AdminMenuButton(
            name: 'Foydalanuvchilar',
            svgname: 'users',
            onPressed: () {
              print('Foydalanuvchilar bosildi');
            },
          ),
          Spacer(),
          AdminMenuButton(
            name: 'Chiqish',
            svgname: 'exit',
            onPressed: () {
              _signOut();
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
