import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayController with TrayListener {
  static Future<void> init() async {
    await trayManager.setIcon(
      'assets/images/logo.ico', 
    );

    await trayManager.setContextMenu(Menu(items: [
      MenuItem(key: 'open', label: 'Ochilish'),
      MenuItem(key: 'exit', label: 'Chiqish'),
    ]));

    trayManager.addListener(_instance);
  }

  static final _instance = TrayController();

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
        break;
      case 'exit':
        trayManager.destroy();
        windowManager.destroy();
        break;
    }
  }
}
