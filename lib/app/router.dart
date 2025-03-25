import 'package:e_hujjat/common/db/cache.dart';
import 'package:e_hujjat/pages/login_screen.dart';
import 'package:go_router/go_router.dart';


abstract final class Routes {
  static const loginPage = '/loginPage';
  static const home = '/home';
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
      path: Routes.loginPage,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

  ],
);
