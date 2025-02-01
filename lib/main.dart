import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:e_hujjat/common/provider/page_provider.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/card_provider.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/provider/step_two_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/app/app.dart';
import 'package:e_hujjat/common/locale/notifiers/locale_notifier.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/db/cache.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLocalization.logger.enableLevels = [];
  await EasyLocalization.ensureInitialized();
  await initializeCache();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: LocaleNotifier.supportedLocales,
      startLocale: LocaleNotifier.startLocale,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(cache)),
          ChangeNotifierProvider(create: (_) => ControlCardProvider()),
          ChangeNotifierProvider(create: (_) => StepTwoProvider()),
          ChangeNotifierProvider(create: (_) => PageProvider()),
        ],
        child: const App(),
      ),
    ),
  );
  doWhenWindowReady(() {
    const initialSize = Size(1366, 768);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Nazorat varaqasi";
    appWindow.show();
  });
}
