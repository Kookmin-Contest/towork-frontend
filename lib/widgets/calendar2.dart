import 'package:flutter/material.dart';
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
          focusedDay: DateTime.now(),
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2023, 12, 31),
          startingDayOfWeek: StartingDayOfWeek.sunday,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) =>
                DateFormat('yyyy.MM').format(date),
            leftChevronIcon: Icon(Icons.chevron_left),
            rightChevronIcon: Icon(Icons.chevron_right),
            headerPadding: EdgeInsets.symmetric(horizontal: 68),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) {
              final days = ['월', '화', '수', '목', '금', '토', '일'];
              return days[date.weekday - 1];
            },
          ),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final days = ['월', '화', '수', '목', '금', '토', '일'];
              if (day.weekday == DateTime.sunday ||
                  day.weekday == DateTime.saturday) {
                return Center(
                  child: Text(
                    days[day.weekday - 1],
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    days[day.weekday - 1],
                  ),
                );
              }
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
