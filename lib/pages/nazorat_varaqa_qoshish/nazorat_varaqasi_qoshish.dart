import 'package:e_hujjat/common/helpers/request_helper.dart';
import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NazoratVaraqasiQoshish extends StatelessWidget {
  const NazoratVaraqasiQoshish({super.key});

  Future<void> getDepartments() async {
    try {
      final response =
          await requestHelper.get('/api/references/get-departments');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themeProvider.getColor('foreground'),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFF5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 7,
                          ),
                          SvgPicture.asset('assets/images/masul.svg'),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Mas’ullar haqida ma’lumot')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 13,
                          ),
                          SizedBox(
                            height: 70,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            'assets/images/nazorat.svg',
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Nazorat haqida ma’lumot')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 13,
                          ),
                          SizedBox(
                            height: 70,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset('assets/images/nazorat.svg'),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Mazmuni haqida ma’lumot')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: themeProvider.getColor('foreground'),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mas’ullar haqida ma’lumot',
                          style: themeProvider.getTextStyle().copyWith(
                              color: themeProvider.getColor('icon'),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nazorat varaqasi uchun Qo’riqlash bosh boshqarma boshlig’ining o’rinbosarlarni mas’ul qilib belgilab berasiz.',
                          style: themeProvider.getTextStyle().copyWith(
                                color: themeProvider.getColor('icon'),
                              ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
