import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

///I followed the example on the package reference site
///https://pub.dev/packages/syncfusion_flutter_charts/example
class HeartBeatLineChart extends StatefulWidget {
  const HeartBeatLineChart({super.key});

  @override
  HeartBeatLineChartState createState() => HeartBeatLineChartState();
}

class HeartBeatLineChartState extends State<HeartBeatLineChart> {
  List chartData = [];

//Importing the Json file
  Future loadStepsData() async {
    final String caloriesResponse =
        await rootBundle.loadString('assets/heartrate.json');
    final caloriesData = await json.decode(caloriesResponse);
    setState(() {
      chartData = caloriesData['activities-heart'];
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
        title: const Text('Heart Beat Line Chart'),
      ),
      body: Column(children: [
        //Initialize the chart widget
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Heart Beat by date'),
          //Memorandum
          legend: Legend(isVisible: true),
          //ToolTip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<dynamic, String>>[
            LineSeries<dynamic, String>(
                //Setting the axes of my graph
                //X -> Date || Y -> Heart Rate
                dataSource: chartData,
                xValueMapper: (dynamic year, _) => year['dateTime'],
                yValueMapper: (dynamic year, _) => year['heartRate'],
                name: 'Heart Beat',
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ],
        ),
        //The Big Line Chart at the bottom for a better view of the Chart
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
              xValueMapper: (int index) => chartData[index]['dateTime'],
              yValueMapper: (int index) => chartData[index]['heartRate'],
              dataCount: chartData.length,
            ),
          ),
        )
      ]),
    );
  }
}

class HeartBeatData {
  HeartBeatData(this.startTime, this.heartRate);

  final String startTime;
  final int heartRate;

  factory HeartBeatData.fromJson(Map<String, dynamic> parsedJson) {
    return HeartBeatData(
      parsedJson['dateTime'],
      parsedJson['heartRate'],
    );
  }
}
