import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/auth/login_screen.dart';
import 'package:e_hujjat/pages/bolim_boshliqlari/bolim_boshliqlari_page.dart';
import 'package:e_hujjat/pages/boshqarma_boshliqlari/boshqarma_boshliqlari_page.dart';
import 'package:e_hujjat/pages/inspektorlar/inspektorlar_page.dart';
import 'package:e_hujjat/pages/orinbosarlar/orinbosarlar_page.dart';
import 'package:e_hujjat/pages/supper_admin/supper_admin_page.dart';
import 'package:go_router/go_router.dart';
import 'package:e_hujjat/pages/home_page.dart';
import 'package:e_hujjat/pages/kotibiyat/kotibiyat_page.dart';

abstract final class Routes {
  static const home = '/home';
  static const loginPage = '/loginPage';
  static const kotibiyatPage = '/kotibiyatPage';
  static const orinbosarlarPage = '/orinbosarlarPage';
  static const boshqarmaBoshliqlariPage = '/boshqarmaBoshliqlariPage';
  static const bolimBoshliqlariPage = '/bolimBoshliqlariPage';
  static const inspektorlarPage = '/inspektorlarPage';
  static const supperAdminPage = '/supperAdminPage';
}

String _initialLocation() {
  final userToken = cache.getString("user_token");

  if (userToken != null) {
    return Routes.home;
  } else {
    return Routes.loginPage;
  }
}

Object? _initialExtra() {
  return Routes.home;
}

final router = GoRouter(
  initialLocation: _initialLocation(),
  initialExtra: _initialExtra(),
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: Routes.loginPage,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.kotibiyatPage,
      builder: (context, state) {
        return const KotibiyatPage();
      },
    ),
    GoRoute(
      path: Routes.orinbosarlarPage,
      builder: (context, state) {
        return const OrinbosarlarPage();
      },
    ),
    GoRoute(
        path: Routes.boshqarmaBoshliqlariPage,
        builder: (context, state) {
          return const BoshqarmaBoshliqlariPage();
        }),
    GoRoute(
      path: Routes.bolimBoshliqlariPage,
      builder: (context, state) {
        return const BolimBoshliqlariPage();
      },
    ),
    GoRoute(
      path: Routes.inspektorlarPage,
      builder: (context, state) {
        return const InspektorlarPage();
      },
    ),
    GoRoute(
        path: Routes.supperAdminPage,
        builder: (context, state) {
          return const SupperAdminPage();
        }),
  ],
);
