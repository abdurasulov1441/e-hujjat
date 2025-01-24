import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/menu.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';

import 'package:e_hujjat/pages/kotibiyat/secondPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InspektorlarPage extends StatefulWidget {
  const InspektorlarPage({super.key});

  @override
  State<InspektorlarPage> createState() => _InspektorlarPageState();
}

class _InspektorlarPageState extends State<InspektorlarPage> {
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              MyCustomAppBar(),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          UniversalMenu(onMenuSelected: updatePage),
                        ],
                      ),
                      Expanded(
                        child: currentPage,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
