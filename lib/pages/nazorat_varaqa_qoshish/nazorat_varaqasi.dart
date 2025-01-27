import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/stepOne.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/stepThree.dart';
import 'package:e_hujjat/pages/nazorat_varaqa_qoshish/stepTwo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';

class NazoratVaraqasiQoshish extends StatefulWidget {
  const NazoratVaraqasiQoshish({super.key});

  @override
  State<NazoratVaraqasiQoshish> createState() => _NazoratVaraqasiQoshishState();
}

class _NazoratVaraqasiQoshishState extends State<NazoratVaraqasiQoshish> {
  int _currentStep = 0;

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.getColor('background'),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: themeProvider.getColor('foreground'),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(Icons.person,
                        color: _currentStep == 0
                            ? themeProvider.getColor('icon')
                            : Colors.black),
                    title: Text('Mas’ullar haqida ma’lumot',
                        style: TextStyle(
                            color: _currentStep == 0
                                ? themeProvider.getColor('icon')
                                : Colors.black)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 58,
                    child:
                        VerticalDivider(color: themeProvider.getColor('text')),
                  ),
                  ListTile(
                    leading: Icon(Icons.description,
                        color: _currentStep == 1
                            ? themeProvider.getColor('icon')
                            : Colors.black),
                    title: Text('Nazorat haqida ma’lumot',
                        style: TextStyle(
                            color: _currentStep == 1
                                ? themeProvider.getColor('icon')
                                : Colors.black)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 58,
                    child:
                        VerticalDivider(color: themeProvider.getColor('text')),
                  ),
                  ListTile(
                    leading: Icon(Icons.info,
                        color: _currentStep == 2
                            ? themeProvider.getColor('icon')
                            : Colors.black),
                    title: Text('Mazmuni haqida ma’lumot',
                        style: TextStyle(
                            color: _currentStep == 2
                                ? themeProvider.getColor('icon')
                                : Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IndexedStack(
              index: _currentStep,
              children: [
                StepOne(onNext: () => _goToStep(1)),
                StepTwo(
                    onNext: () => _goToStep(2), onPrevious: () => _goToStep(0)),
                StepThree(onPrevious: () => _goToStep(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
