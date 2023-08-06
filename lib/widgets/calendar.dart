import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<DateTime> holidays = [
    DateTime(2023, 1, 1),
    DateTime(2023, 3, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TableCalendar(
          focusedDay: DateTime.now().toLocal(),
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2023, 12, 31),
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) =>
                DateFormat('yyyy.MM').format(date),
            leftChevronIcon: Icon(Icons.chevron_left),
            rightChevronIcon: Icon(Icons.chevron_right),
            headerPadding: EdgeInsets.only(right: 40.w),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              final days = ['월', '화', '수', '목', '금', '토', '일'];
              return days[date.weekday - 1];
            },
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Icon(Icons.alarm),
        )
      ],
    );
  }
}
