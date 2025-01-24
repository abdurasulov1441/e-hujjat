import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/provider/change_notifier_provider.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      title: 'Nazorat Varaqasi',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      routerConfig: router,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
