import 'package:e_hujjat/common/widgets/bottom_card.dart';
import 'package:e_hujjat/common/widgets/calendar.dart';
import 'package:e_hujjat/common/widgets/diagram.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:e_hujjat/common/provider/page_provider.dart';
import 'package:e_hujjat/common/widgets/statistic.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/widgets/app_bar.dart';
import 'package:e_hujjat/common/widgets/menu.dart';
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
    final pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: MyCustomAppBar(),
      // backgroundColor: themeProvider.getColor('background'),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: UniversalMenu(
                  onMenuSelected: (page) {
                    pageProvider.updatePage(page);
                  },
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return pageProvider.currentPage;
                },
              ),
            ),
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
