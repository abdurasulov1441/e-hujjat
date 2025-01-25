import 'package:e_hujjat/app/router.dart';
import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/nazorat_varaqasi_qoshish.dart';
import 'package:e_hujjat/pages/nazorat_varaqalari_page/nazorat_varaqalari.dart';

import 'package:flutter/material.dart';
import 'package:e_hujjat/common/menu_button.dart';
import 'package:provider/provider.dart';

class PageProvider with ChangeNotifier {
  List<Map<String, dynamic>> menuItems = [];
  Widget _currentPage = const MainPageElements();

  Widget get currentPage => _currentPage;

  Future<void> fetchMenu() async {
    try {
      final response = await requestHelper
          .getWithAuth('/api/references/get-menus', log: true);
      menuItems = response
          .map<Map<String, dynamic>>((item) => {
                'menu': item['menu'],
                'route': item['route'],
                'icon': item['icon'],
                'page': _getPageByRoute(item['route']),
              })
          .toList();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void setCurrentPage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }

  Widget _getPageByRoute(String route) {
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
}

class UniversalMenu extends StatelessWidget {
  const UniversalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pageProvider = Provider.of<PageProvider>(context);

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: themeProvider.getColor('foreground'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: pageProvider.menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = pageProvider.menuItems[index];
                final isSelected = pageProvider.currentPage == menuItem['page'];

                return AdminMenuButton(
                  name: menuItem['menu'],
                  svgname: menuItem['icon'],
                  onPressed: () {
                    pageProvider.setCurrentPage(menuItem['page']);
                  },
                  isSelected: isSelected,
                );
              },
            ),
          ),
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
      cache.clear();
      router.go(Routes.loginPage);
    } catch (error) {
      print(error);
    }
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: MyCustomAppBar(),
      backgroundColor: themeProvider.getColor('background'),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const UniversalMenu(),
            ),
          ),
          Flexible(
            flex: 4,
            child: pageProvider.currentPage,
          ),
        ],
      ),
    );
  }
}
