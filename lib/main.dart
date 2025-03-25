import 'package:e_hujjat/app/router.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:e_hujjat/pages/login_screen.dart';
import 'package:e_hujjat/common/db/cache.dart';
import 'package:e_hujjat/common/socket_service.dart';

final socketIOService = SocketIOService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await cache.init();

  await trayManager.setIcon('assets/images/logo.ico');
  trayManager.addListener(MyTrayListener());
  await trayManager.setContextMenu(Menu(items: [
    MenuItem(key: 'open', label: 'Ochilish'),
    MenuItem(key: 'exit', label: 'Chiqish'),
  ]));

  final userId = cache.getInt('user_id');
  if (userId != null) {
    socketIOService.connect(userId);
  }

  WindowOptions windowOptions = WindowOptions(
    size: const Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: userId != null,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions).then((_) async {
    if (userId != null) {
      await windowManager.hide();
    } else {
      await windowManager.show();
    }
  });

  runApp(MyApp(hasUser: userId != null));
}

class MyApp extends StatelessWidget {
  final bool hasUser;

  const MyApp({super.key, required this.hasUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasUser
          ? Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(),
            )
          : const LoginScreen(),
    );
  }
}

class MyTrayListener with TrayListener {
  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'open':
        await windowManager.show();
        await windowManager.setSkipTaskbar(false);
        router.go(Routes.loginPage);
        break;
      case 'exit':
        socketIOService.disconnect();
        trayManager.destroy();
        windowManager.destroy();
        cache.clear();
        break;
    }
  }
}
