import 'package:fitness_app/day_item.dart';
import 'package:flutter/material.dart';

enum PeriodSelection { Day, Moths }

class GraphWidget extends StatefulWidget {
  //Datos de prueba que vendrian del backend
  List<int> dayValues = [55, 58, 45, 25, 55, 45, 60, 45];
  List<int> mothValues = [50, 63, 0, 100, 35, 15, 77, 22];
  List<String> dayLabels = [
    "28.01",
    "30.01",
    "01.02",
    "04.02",
    "06.02",
    "08.02",
    "11.02",
    "13.02"
  ];
  List<String> mothLabels = ["01", "02", "03", "04", "05", "06", "07", "08"];

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  PeriodSelection periodSelected = PeriodSelection.Day;

  @override
  Widget build(BuildContext context) {
    List<int> values;
    List<String> labels;

    if (periodSelected == PeriodSelection.Day) {
      values = widget.dayValues;
      labels = widget.dayLabels;
    } else {
      values = widget.mothValues;
      labels = widget.mothLabels;
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      periodSelected = PeriodSelection.Day;
                    });
                  },
                  child: Text(
                    "Day",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: periodSelected == PeriodSelection.Day
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      periodSelected = PeriodSelection.Moths;
                    });
                  },
                  child: Text(
                    "Month",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: periodSelected == PeriodSelection.Moths
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "visits in mins",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              List<Widget> rows = [];

              values.asMap().forEach((index, value) {
                var label = labels[index];
                rows.add(dayItem(label, value, constraints.maxHeight));
              });

              return Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: rows,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

Widget dayItem(String day, int value, double maxHeight) {
  return DayItem(day: day, value: value, maxHeight: maxHeight);
}
