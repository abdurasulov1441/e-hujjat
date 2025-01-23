import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/auth/login_screen.dart';
import 'package:e_hujjat/pages/bolim_boshliqlari/bolim_boshliqlari_page.dart';
import 'package:e_hujjat/pages/boshqarma_boshliqlari/boshqarma_boshliqlari_page.dart';
import 'package:e_hujjat/pages/inspektorlar/inspektorlar_page.dart';
import 'package:e_hujjat/pages/orinbosarlar/orinbosarlar_page.dart';
import 'package:e_hujjat/pages/supper_admin/supper_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/pages/kotibiyat/kotibiyat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user_role = cache.getInt('user_role');

    switch (user_role) {
      case 1:
        return SupperAdminPage();

      case 2:
        return KotibiyatPage();
      case 3:
        return OrinbosarlarPage();
      case 4:
        return BoshqarmaBoshliqlariPage();
      case 5:
        return BolimBoshliqlariPage();
      case 6:
        return InspektorlarPage();

      default:
        return LoginScreen();
    }
  }
}
