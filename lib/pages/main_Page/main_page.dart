import 'package:e_hujjat/common/bottom_card.dart';
import 'package:e_hujjat/common/calendar.dart';
import 'package:e_hujjat/common/diagram.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/common/statistic.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/app_bar.dart';
import 'package:e_hujjat/common/menu.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _KotibiyatPageState();
}

class _KotibiyatPageState extends State<MainPage> {
  Widget currentPage = MainPageElements();

  void updatePage(Widget page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: MyCustomAppBar(),
      backgroundColor: themeProvider.getColor('background'),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: UniversalMenu(onMenuSelected: updatePage),
              ),
            ),
            Flexible(flex: 4, child: currentPage),
          ],
        ),
      ),
    );
  }
}

class MainPageElements extends StatelessWidget {
  const MainPageElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminStatistic(),
        Row(
          children: [
            Diagram(),
            AdminDashboardCalendar(),
          ],
        ),
        BottomCard(),
      ],
    );
  }
}
