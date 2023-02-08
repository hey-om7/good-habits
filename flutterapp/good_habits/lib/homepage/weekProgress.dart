import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../globalFunctions.dart';

class WeekProgress extends StatelessWidget {
  const WeekProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Blur(
            colorOpacity: 0.1,
            blurColor: Colors.black.withOpacity(0.3),
            blur: 1.5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 100,
            ),
          ),
        ),
        Container(
            width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 30),
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: FutureBuilder(
              future: getTodaysDate(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // WeekEachDayProgress(weekdayname: "M", progress: 0.2),
                      // WeekEachDayProgress(weekdayname: "T", progress: 0.1),
                      // WeekEachDayProgress(
                      //   weekdayname: "W",
                      //   progress: 0.8,
                      //   isactive: true,
                      // ),
                      // WeekEachDayProgress(weekdayname: "T", progress: 0.2),
                      // WeekEachDayProgress(weekdayname: "F", progress: 0.6),
                      // WeekEachDayProgress(weekdayname: "S", progress: 0.3),
                      // WeekEachDayProgress(weekdayname: "S", progress: 0.95)
                      ...List.generate(snapshot.data.length, (index) {
                        return WeekEachDayProgress(
                          weekdayname: snapshot.data[index][0],
                          progress: 0.2 + index / 10,
                          isactive: snapshot.data[index][1] == 1,
                        );
                      })
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            )),
      ],
    );
  }
}

Future getTodaysDate() async {
  Map<String, int> _weekdays = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursday": 3,
    "Friday": 4,
    "Saturday": 5,
    "Sunday": 6
  };
  _weekdays[DateFormat('EEEE').format(DateTime.now())];
  List _returnableList = [];
  _weekdays.forEach((key, value) {
    _returnableList.add([
      key.substring(0, 1),
      key == DateFormat('EEEE').format(DateTime.now()) ? 1 : 0
    ]);
  });
  // print(_returnableList);
  return _returnableList;
}

class WeekEachDayProgress extends StatelessWidget {
  WeekEachDayProgress(
      {required this.weekdayname, required this.progress, this.isactive});
  final String weekdayname;
  final double progress;
  final bool? isactive;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 33,
          width: 33,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            color: isactive == null || isactive == false
                ? Colors.white
                : Color(0xffFFCC7E),
            backgroundColor: Colors.white.withOpacity(0.2),
          ),
        ),
        myText(
          text: weekdayname,
          size: 15,
          color: isactive == null || isactive == false
              ? Colors.white
              : Color(0xffFFCC7E),
        ),
      ],
    );
  }
}
