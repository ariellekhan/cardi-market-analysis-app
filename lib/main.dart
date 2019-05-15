import 'package:flutter/material.dart';
import 'bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(new MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List _countries = ["Trinidad and Tobago", "Barbados", "Guyana", "Jamaica"];
  List _commoditiesTT = ["Cassava", "Local Dasheen", "Imported Dasheen", "Local sweet pepper", "Imported sweet pepper", "Hot pepper"];
  List _commoditiesJA = ["Dasheen", "Sweet pepper", "Hot pepper"];
  List _commoditiesBB = ["Cassava", "Sweet pepper", "Hot pepper"];
  List _commoditiesGY = ["Cassava", "Sweet pepper", "Hot pepper"];


  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuBB;
  List<DropdownMenuItem<String>> _dropDownMenuGY;
  List<DropdownMenuItem<String>> _dropDownMenuTT;
  List<DropdownMenuItem<String>> _dropDownMenuJA;
  List<DropdownMenuItem<String>> _dropDownMenuSelected;

  String _selectedCountry;
  String _selectedCommodity;

  SimpleBarChart b = new SimpleBarChart.withSampleData();

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_countries);
    _dropDownMenuBB = buildAndGetDropDownMenuItems(_commoditiesBB);
    _dropDownMenuTT = buildAndGetDropDownMenuItems(_commoditiesTT);
    _dropDownMenuGY = buildAndGetDropDownMenuItems(_commoditiesGY);
    _dropDownMenuJA = buildAndGetDropDownMenuItems(_commoditiesJA);
    _selectedCountry = _dropDownMenuItems[0].value;
    _selectedCommodity = _dropDownMenuTT[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedCountry = selectedFruit;
    });
  }

  void changedDropDownItem2(String selectedFruit) {
    setState(() {
      _selectedCommodity = selectedFruit;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedCountry == _dropDownMenuItems[0].value){
      _dropDownMenuSelected = _dropDownMenuTT;
    }
    else if (_selectedCountry == _dropDownMenuItems[1].value){
      _dropDownMenuSelected = _dropDownMenuBB;
    }
    else if (_selectedCountry == _dropDownMenuItems[2].value){
      _dropDownMenuSelected = _dropDownMenuGY;
    }
    else if (_selectedCountry == _dropDownMenuItems[3].value){
      _dropDownMenuSelected = _dropDownMenuJA;
    }

//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("MARKET ANALYSIS"),
//          centerTitle: true,
//          backgroundColor: Colors.blueGrey,
//        ),
//        body: new SimpleBarChart.withSampleData(),

      return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Image.asset("assets/tt_flag.png")),
                  Tab(icon: Image.asset("assets/bb_flag.png")),
                  Tab(icon: Image.asset("assets/gy_flag.png")),
                  Tab(icon: Image.asset("assets/ja_flag.png")),
                ],
              ),
              title: Text('MARKET ANALYSIS'),
              centerTitle: true,
              backgroundColor: Colors.blueGrey,
            ),
            body: TabBarView(
              children: [
//                Icon(Icons.directions_car),
                new SimpleBarChart.withSampleData(),

                new DropdownButton(
                    value: _selectedCommodity,
                    items: _dropDownMenuSelected,
                    onChanged: changedDropDownItem2,
                  ),

                Icon(Icons.directions_transit),

                Icon(Icons.directions_bike),
              ],
            ),
          ),
        )

// ListView(children: [
//          Padding(
//            padding: EdgeInsets.all(8.0),
//            child: Container(
//              child: Center(
//                child: Column(
//                  children: <Widget>[
//                    Text("Trinidad and Tobago"),
//                    Expanded(
//                      child: new SimpleBarChart.withSampleData(),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ]),




//        Center(
//                child: new Column( children: <Widget>[
//                  new DropdownButton(
//                    value: _selectedCountry,
//                    items: _dropDownMenuItems,
//                    onChanged: changedDropDownItem,
//                  ),
//                  new DropdownButton(
//                    value: _selectedCommodity,
//                    items: _dropDownMenuSelected,
//                    onChanged: changedDropDownItem2,
//                  ),
//                  SimpleBarChart.withSampleData(),
//                ],
//                ),
//              ),
      );
  }
}