// ignore_for_file: avoid_print, no_logic_in_create_state

import 'dart:convert';

import 'package:cardiotoxicity/dbUser.dart';
import 'package:cardiotoxicity/drawer.dart';
import 'package:cardiotoxicity/educationalMaterial.dart';
import 'package:cardiotoxicity/lineCharts/heartBeat_line_chart.dart';
import 'package:cardiotoxicity/lineCharts/steps_line_chart.dart';
import 'package:cardiotoxicity/quoteOfTheDay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String username, password;

  const HomePage({super.key, required this.username, required this.password});

  @override
  HomePageState createState() => HomePageState(username, password);
}

class HomePageState extends State<HomePage> {
  String username, password;

  HomePageState(this.username, this.password);

  late Future<QuoteModel> futureQuote;
  List caloriesItems = [];
  List heartRateItems = [];

  Future<void> readJson() async {
    final String caloriesResponse =
        await rootBundle.loadString('assets/response_calories_steps.json');
    final caloriesData = await json.decode(caloriesResponse);
    final String heartRateResponse =
        await rootBundle.loadString('assets/heartrate.json');
    final heartRateData = await json.decode(heartRateResponse);
    setState(() {
      caloriesItems = caloriesData['activities'];
      //print(caloriesItems);
      heartRateItems = heartRateData['activities-heart'];
      //print(heartRateItems);
    });
  }

  @override
  void initState() {
    // Call the readJson method and the fetchQuote method when the app starts
    readJson();
    futureQuote = fetchQuote();
    super.initState();
  }

  num avgHeartRate() {
    num heartRateTotal = 0;
    for (int i = 0; i < heartRateItems.length; i++) {
      heartRateTotal = heartRateTotal + heartRateItems[i]['heartRate'];
      print('Heart rate total: $heartRateTotal');
    }
    num avgHeartRate = heartRateTotal / heartRateItems.length;
    print('Average heart rate: $avgHeartRate');
    return avgHeartRate;
  }

  @override
  Widget build(BuildContext context) {
    int caloriesTotalIndexes = caloriesItems.length;
    int lastStep = caloriesItems[caloriesTotalIndexes - 1]["steps"];
    var f = NumberFormat("###.0##");
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $username'),
      ),
      drawer: MainDrawer(
        username: username,
        password: password,
      ),
      body: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 1,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.purpleAccent,
                  child: Column(
                    children: [
                      const Text(
                        'Quote of the Day',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      FutureBuilder<QuoteModel>(
                        future: futureQuote,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String? quote = snapshot.data!.slip!.advice ??
                                'Advice of the day';
                            return Text(quote,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 15));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator(
                            strokeWidth: 2,
                          );
                        },
                      ),
                    ],
                  ))
              //Tile(index: 0),
              ),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Educational Material',
                      style: TextStyle(fontSize: 25, color: Colors.deepPurple),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: IconButton(
                        tooltip: 'Educational Material',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EducationalMaterial()),
                          );
                        },
                        icon: const Icon(Icons.book, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
              //Tile(index: 0),
              ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StepsLineChart()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.monitor_heart, color: Colors.white),
                          Text(
                            'Walk',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Subtracting the goal which is 8000 - the last index from the json file
                          Text('Remaining: ${8000 - lastStep}',
                              style: const TextStyle(fontSize: 20)),
                          Text('$lastStep',
                              style: const TextStyle(fontSize: 30)),
                          const Text('steps', style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.system_security_update_good,
                            color: Colors.white,
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HeartBeatLineChart()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.monitor_heart, color: Colors.white),
                          Text(
                            'HeartBeat',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Avg', style: TextStyle(fontSize: 20)),
                          Text(f.format(avgHeartRate()),
                              style: const TextStyle(fontSize: 30)),
                          const Text('bpm', style: TextStyle(fontSize: 20))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.watch,
                            color: Colors.white,
                          ),
                          Text(
                            'Watch',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Demographics',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserData(
                                    username: username,
                                    password: password,
                                  )),
                        );
                      },
                      icon: const Icon(Icons.settings, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Add Event',
                    style:
                        TextStyle(fontSize: 25, color: Colors.lightBlueAccent),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
