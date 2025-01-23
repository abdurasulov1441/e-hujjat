import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_hujjat/common/style/app_colors.dart';
import 'package:e_hujjat/common/style/app_style.dart';

class AdminStatistic extends StatelessWidget {
  const AdminStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1046,
      height: 100,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10, left: 15),
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          StatisticsWidgetNew(
            svgname: 'assets/images/nazorat_varaqasi.svg',
            text: 'Nazorat varaqasi',
            number: '127',
          ),
          StatisticsWidgetNew(
            svgname: 'assets/images/new.svg',
            text: 'Yangi',
            number: '127',
          ),
          StatisticsWidgetNew(
            svgname: 'assets/images/acepted.svg',
            text: 'Qabul qilingan',
            number: '25',
          ),
          StatisticsWidgetNew(
            svgname: 'assets/images/completed.svg',
            text: 'Bajarilgan',
            number: '33',
          ),
        ],
      ),
    );
  }
}

class StatisticsWidgetNew extends StatelessWidget {
  const StatisticsWidgetNew(
      {super.key,
      required this.svgname,
      required this.text,
      required this.number});

  final String svgname;
  final String text;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 247,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundColor),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            svgname,
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: AppStyle.fontStyle,
              ),
              Text(
                '$number ta',
                style: AppStyle.fontStyle.copyWith(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
