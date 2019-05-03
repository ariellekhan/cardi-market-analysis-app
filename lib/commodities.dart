import 'package:flutter/material.dart';
import 'main.dart';

class Commodities extends StatefulWidget {

  static String tag = 'Commodities';

  @override
  _CommoditiesState createState() => new _CommoditiesState();
}

class _CommoditiesState extends State<Commodities> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('Cassava'),
                  subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  onTap: null,
                ),
              ],
          ),),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('The Enchanted Nightingale'),
                  subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),),
    ],),
    );
  }


}