// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StepsLineChart extends StatefulWidget {
  const StepsLineChart({super.key});

  @override
  StepsLineChartState createState() => StepsLineChartState();
}

class StepsLineChartState extends State<StepsLineChart> {
  List chartData = [];

  Future loadStepsData() async {
    //Importing the Json file
    final String caloriesResponse =
        await rootBundle.loadString('assets/response_calories_steps.json');
    final caloriesData = await json.decode(caloriesResponse);
    setState(() {
      chartData = caloriesData['activities'];
      //Printing the Json file to the console for debugging
      print(chartData);
    });
  }

//Loading the Json file from the beginning
  @override
  void initState() {
    loadStepsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Steps Line Chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Steps by date'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<dynamic, String>>[
              LineSeries<dynamic, String>(
                  //Setting the axes of my graph
                  //X -> Date || Y -> Steps
                  dataSource: chartData,
                  xValueMapper: (dynamic year, _) =>
                      //Getting only the first 10 characters from the startTime String which is the date(including spaces)
                      year['startTime'].toString().substring(0, 10),
                  yValueMapper: (dynamic year, _) => year['steps'],
                  name: 'Steps',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => chartData[index]['startTime'],
                yValueMapper: (int index) => chartData[index]['steps'],
                dataCount: chartData.length,
              ),
            ),
          )
        ]));
  }
}

class StepsData {
  StepsData(this.startTime, this.steps);

  final String startTime;
  final int steps;

  factory StepsData.fromJson(Map<String, dynamic> parsedJson) {
    return StepsData(
      parsedJson['startTime'],
      parsedJson['steps'],
    );
  }
}
