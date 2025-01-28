import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/nazorat_varaqasi.dart';
import 'package:e_hujjat/pages/nazorat_varaqalari_page/nazorat_varaqalari.dart';

import 'package:flutter/material.dart';
import 'package:e_hujjat/common/menu_button.dart';

import 'package:provider/provider.dart';

class UniversalMenu extends StatefulWidget {
  final Function(Widget) onMenuSelected;

  const UniversalMenu({super.key, required this.onMenuSelected});

  @override
  State<UniversalMenu> createState() => _UniversalMenuState();
}

class _UniversalMenuState extends State<UniversalMenu> {
  List<String> menu = [];
  List<String> route = [];
  List<String> icon = [];
  List<Widget> pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  Future<void> getMenu() async {
    try {
      final response = await requestHelper
          .getWithAuth('/api/references/get-menus', log: true);

      setState(() {
        for (var item in response) {
          menu.add(item['menu']);
          route.add(item['route']);
          icon.add(item['icon']);
          pages.add(getPageByRoute(item['route']));
        }
        print(route);
      });
    } catch (error) {
      print(error);
    }
  }

  Widget getPageByRoute(String route) {
    switch (route) {
      case 'dashboardPage':
        return const MainPageElements();
      case 'nazoratVaraqasiPage':
        return const NazoratVaraqalari();
      case 'bolimlarPage':
        return const Calendar();
      case 'nazoratVaraqasiQoshishPage':
        return const NazoratVaraqasiQoshish();
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: themeProvider.getColor('foreground'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 420,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return AdminMenuButton(
                  name: menu[index],
                  svgname: icon[index],
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onMenuSelected(pages[index]);
                  },
                  isSelected: isSelected,
                );
              },
            ),
          ),
          Spacer(),
          AdminMenuButton(
            name: 'Chiqish',
            svgname: 'assets/images/exit.svg',
            onPressed: () async {
              await _signOut();
            },
            isSelected: false,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      // await requestHelper.postWithAuth('/api/auth/logout', {}, log: true);
      cache.clear();
      router.go(Routes.loginPage);
    } catch (error) {
      print(error);
    }
  }
}
