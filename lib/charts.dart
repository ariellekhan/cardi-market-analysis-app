import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Chart extends StatefulWidget {

  static String tag = 'Chart';

  @override
  _ChartState createState() => new _ChartState();
}

class _ChartState extends State<Chart> {


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chart"),
        ),


      );

  }

}

class ClicksPerYear {
  final String year;
  final int clicks;

  ClicksPerYear(this.year, this.clicks);
}