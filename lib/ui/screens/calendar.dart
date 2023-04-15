import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  static const routeName = '/calendar';
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's attendance"),
      ),
      body: SafeArea(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 10, 20),
          lastDay: DateTime.utc(2040, 10, 20),
          headerVisible: true,
          daysOfWeekVisible: true,
          sixWeekMonthsEnforced: true,
          shouldFillViewport: false,
          
          headerStyle: HeaderStyle(titleTextStyle: TextStyle(fontSize: 20, color:Colors.teal, fontWeight: FontWeight.w600)),
          calendarStyle: CalendarStyle(todayTextStyle: TextStyle(fontSize: 20, color:Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
