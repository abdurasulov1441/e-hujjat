import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:e_hujjat/common/style/app_colors.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 515,
      height: 250,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 10, left: 15),
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: AdminDashboardCalendar(),
    );
  }
}

class AdminDashboardCalendar extends StatefulWidget {
  const AdminDashboardCalendar({super.key});

  @override
  State<AdminDashboardCalendar> createState() => _AdminDashboardCalendarState();
}

class _AdminDashboardCalendarState extends State<AdminDashboardCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: 10, left: 10),
        decoration: BoxDecoration(
            color: AppColors.foregroundColor,
            borderRadius: BorderRadius.circular(10)),
        width: 100,
        height: 100,
        child: SimpleCalendarPage());
  }
}

class SimpleCalendarPage extends StatelessWidget {
  const SimpleCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime?> selectedDate = [DateTime.now()];

    return Center(
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          selectedDayHighlightColor: Colors.orange,
          firstDayOfWeek: 1,
        ),
        value: selectedDate,
        onValueChanged: (dates) {
          print('Выбрана дата: ${dates.first}');
        },
      ),
    );
  }
}
