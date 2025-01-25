import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/auth/login_screen.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/nazorat_varaqasi_qoshish.dart';
import 'package:e_hujjat/pages/nazorat_varaqalari_page/nazorat_varaqalari.dart';
import 'package:go_router/go_router.dart';
import 'package:e_hujjat/pages/home_page.dart';
import 'package:e_hujjat/pages/main_Page/main_page.dart';

abstract final class Routes {
  static const home = '/home';
  static const loginPage = '/loginPage';
  static const mainPage = '/mainPage';

  static const nazoratVaraqalari = '/nazoratVaraqalari';

  static const nazoratVaraqasiQoshish = '/nazoratVaraqasiQoshish';
}

String _initialLocation() {
  final userToken = cache.getString("access_token");

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
      path: Routes.mainPage,
      builder: (context, state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: Routes.nazoratVaraqalari,
      builder: (context, state) {
        return const NazoratVaraqalari();
      },
    ),
    GoRoute(
      path: Routes.nazoratVaraqasiQoshish,
      builder: (context, state) {
        return const NazoratVaraqasiQoshish();
      },
    ),
  ],
);
