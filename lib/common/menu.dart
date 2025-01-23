import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/menu_button.dart';
import 'package:e_hujjat/common/style/app_colors.dart';

class UniversalMenu extends StatefulWidget {
  const UniversalMenu({super.key});

  @override
  State<UniversalMenu> createState() => _UniversalMenuState();
}

class _UniversalMenuState extends State<UniversalMenu> {
  List<String> menu = [];
  List<String> route = [];
  List<String> icon = [];

  void initState() {
    super.initState();
    getMenu();
  }

  Future<void> getMenu() async {
    try {
      final response =
          await requestHelper.getWithAuth('/api/references/get-menus');

      for (var item in response) {
        setState(() {
          menu.add(item['menu']);
          route.add(item['route']);
          icon.add(item['icon']);
        });
      }
    } catch (error) {}
  }

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
          SizedBox(
            height: 420,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return AdminMenuButton(
                    name: menu[index],
                    svgname: icon[index],
                    onPressed: () {
                      router.go(route[index]);
                    },
                  );
                }),
          ),
          Spacer(),
          AdminMenuButton(
            name: 'Chiqish',
            svgname: 'assets/images/exit.svg',
            onPressed: _signOut,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
