import 'package:e_hujjat/db/cache.dart';
import 'package:e_hujjat/pages/auth/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:e_hujjat/pages/home_page.dart';
import 'package:e_hujjat/pages/kotibiyat/kotibiyat_page.dart';

abstract final class Routes {
  static const home = '/home';
  static const loginPage = '/loginPage';
  static const kotibiyatPage = '/kotibiyatPage';
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
      path: Routes.kotibiyatPage,
      builder: (context, state) {
        return const KotibiyatPage();
      },
    ),
    GoRoute(
      path: Routes.loginPage,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);
