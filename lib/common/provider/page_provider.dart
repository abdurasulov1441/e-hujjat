import 'package:e_hujjat/common/widgets/calendar.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/nazorat_varaqasi.dart';
import 'package:e_hujjat/pages/nazorat_varaqalari_page/nazorat_varaqalari.dart';
import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {

    Widget _currentPage = const MainPageElements();


  Widget get currentPage => _currentPage;
  void updatePage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }

  void updatePageByRoute(String route) {
    Widget page;
    switch (route) {
      case 'dashboardPage':
        page = const MainPageElements();
        break;
      case 'nazoratVaraqasiPage':
        page = const NazoratVaraqalari();
        break;
      case 'bolimlarPage':
        page = const Calendar();
        break;
      case 'nazoratVaraqasiQoshishPage':
        page = const NazoratVaraqasiQoshish();
        break;
      default:
        page = const Placeholder();
    }
    _currentPage = page;
    notifyListeners();
  }
}
