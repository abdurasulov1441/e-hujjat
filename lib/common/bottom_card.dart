import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Flexible(
        flex: 2,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.only(
            top: 5,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
              color: themeProvider.getColor('foreground'),
              borderRadius: BorderRadius.circular(10)),
        ));
  }
}
