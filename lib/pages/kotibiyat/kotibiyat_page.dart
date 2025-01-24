import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/pages/kotibiyat/secondPage.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/menu.dart';

import 'package:provider/provider.dart';

class KotibiyatPage extends StatefulWidget {
  const KotibiyatPage({super.key});

  @override
  State<KotibiyatPage> createState() => _KotibiyatPageState();
}

class _KotibiyatPageState extends State<KotibiyatPage> {
  Widget currentPage = Secondpage();

  void updatePage(Widget page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.getColor('background'),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const MyCustomAppBar(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UniversalMenu(onMenuSelected: updatePage),
                Expanded(
                  child: currentPage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
