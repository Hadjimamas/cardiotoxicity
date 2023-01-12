// ignore_for_file: prefer_const_constructors

import 'package:cardiotoxicity/dbUser.dart';
import 'package:cardiotoxicity/lineCharts/steps_line_chart.dart';
import 'package:flutter/material.dart';

import 'educationalMaterial.dart';
import 'lineCharts/heartBeat_line_chart.dart';

class MainDrawer extends StatelessWidget {
  final String username, password;

  const MainDrawer({Key? key, required this.username, required this.password})
      : super(key: key);

  //Declaring a ListTile to use it on the menu items
  Widget buildListTile(String title, IconData icon, BuildContext context,
      Widget Function(BuildContext) builder) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: builder),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            padding: EdgeInsets.all(30),
            alignment: Alignment.bottomLeft,
            color: Colors.deepPurpleAccent,
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          buildListTile("Steps", Icons.directions_walk, context,
              (context) => StepsLineChart()),
          SizedBox(
            height: 10,
          ),
          buildListTile("HeartBeat", Icons.heart_broken, context,
              (context) => HeartBeatLineChart()),
          SizedBox(
            height: 10,
          ),
          buildListTile("Educational Material", Icons.class_, context,
              (context) => EducationalMaterial()),
          SizedBox(
            height: 10,
          ),
          buildListTile("Demographics", Icons.settings, context,
              (context) => UserData(username: username, password: password)),
          SizedBox(
            height: 10,
          ),
          buildListTile("Urine Track", Icons.add, context,
              (context) => HeartBeatLineChart()),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
