import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // Realtime database
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  DatabaseReference dbRef;

  // Commodity dropdown lists
  List _commoditiesTT = [
    "Cassava",
    "Local dasheen",
    "Imported dasheen",
    "Local sweet potato",
    "Imported sweet potato",
    "Hot pepper"
  ];
  List _commoditiesJA = [
    "Dasheen", "Sweet potato", "Scotch bonnet", "West Indian red"];
  List _commoditiesBB = ["Cassava", "Sweet potato", "Hot pepper"];
  List _commoditiesGY = ["Cassava", "Sweet potato", "Hot pepper"];
  List _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuBB;
  List<DropdownMenuItem<String>> _dropDownMenuGY;
  List<DropdownMenuItem<String>> _dropDownMenuTT;
  List<DropdownMenuItem<String>> _dropDownMenuJA;
  List<DropdownMenuItem<String>> _dropDownMenuMonths;
  String _selectedCommodityTT;
  String _selectedCommodityBB;
  String _selectedCommodityGY;
  String _selectedCommodityJA;
  String _selectedMonthTT;
  String _selectedMonthBB;
  String _selectedMonthGY;
  String _selectedMonthJA;
  charts.BarChart chartTT;


  @override
  void initState() {
    // Dropdowns
    _dropDownMenuBB = buildAndGetDropDownMenuItems(_commoditiesBB);
    _dropDownMenuTT = buildAndGetDropDownMenuItems(_commoditiesTT);
    _dropDownMenuGY = buildAndGetDropDownMenuItems(_commoditiesGY);
    _dropDownMenuJA = buildAndGetDropDownMenuItems(_commoditiesJA);
    _dropDownMenuMonths = buildAndGetDropDownMenuItems(_months);
    _selectedCommodityTT = _commoditiesTT[0];
    _selectedCommodityBB = _commoditiesBB[0];
    _selectedCommodityGY = _commoditiesGY[0];
    _selectedCommodityJA = _commoditiesJA[0];
    _selectedMonthTT = _months[0];
    _selectedMonthBB = _months[0];
    _selectedMonthGY = _months[0];
    _selectedMonthJA = _months[0];

    // Database
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(
        10000000); //allocating 10MB of storage in cache
    databaseReference = database.reference();
    databaseReference.onChildAdded.listen(
        _onEntryAdded); //listening for new data added
    databaseReference.onChildChanged.listen(_onEntryChanged);

    dbRef = database.reference();
    dbRef.onChildAdded.listen(
        _onEntryAdded); //listening for new data added
    dbRef.onChildChanged.listen(_onEntryChanged);

    super.initState();
  }

  // Functions for dropdowns
  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItemMonthTT(String selected) {
    setState(() {
      _selectedMonthTT = selected;
    });
  }

  void changedDropDownItemMonthBB(String selected) {
    setState(() {
      _selectedMonthBB = selected;
    });
  }

  void changedDropDownItemMonthGY(String selected) {
    setState(() {
      _selectedMonthGY = selected;
    });
  }

  void changedDropDownItemMonthJA(String selected) {
    setState(() {
      _selectedMonthJA = selected;
    });
  }

  void changedDropDownItemTT(String selectedCommodity) {
    setState(() {
      _selectedCommodityTT = selectedCommodity;
    });
  }

  void changedDropDownItemBB(String selectedCommodity) {
    setState(() {
      _selectedCommodityBB = selectedCommodity;
    });
  }

  void changedDropDownItemGY(String selectedCommodity) {
    setState(() {
      _selectedCommodityGY = selectedCommodity;
    });
  }

  void changedDropDownItemJA(String selectedCommodity) {
    setState(() {
      _selectedCommodityJA = selectedCommodity;
    });
  }

  // End of functions for dropdowns


  @override
  Widget build(BuildContext context) {
    chartTT = charts.BarChart(
      _createChartTT("trinidad&tobago", _selectedCommodityTT, _selectedMonthTT),
      animate: true,);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home, color: Colors.green,)),
                  Tab(icon: Image.asset("assets/tt_flag.png")),
                  Tab(icon: Image.asset("assets/bb_flag.png")),
                  Tab(icon: Image.asset("assets/gy_flag.png")),
                  Tab(icon: Image.asset("assets/ja_flag.png")),
                ],
              ),
              leading: Image.asset("assets/logo.png"),
              title: Text(
                'MARKET ANALYSIS', style: TextStyle(color: Colors.green),),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),

            body:
            TabBarView(
              children: [
                //Tab 1 Home
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/logo.png", scale: 3,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("CARDI Market Price Bulletin", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("This market price bulletin from the Caribbean Agricultural Research and Development Institute (CARDI) tracks wholesale prices each month for selected root crops (cassava, dasheen, sweet potato) and hot peppers from four regional markets, Barbados, Jamaica, Guyana and Trinidad & Tobago, as well as the Miami Terminal Market.(hot peppers)",
                                        style: TextStyle(fontSize: 17.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Other features are previous month’s prices and a price tracker which shows the monthly trends in prices. This information is intended to serve value chain stakeholders (producers, traders, retailers and exporters) across the Region.",
                              style: TextStyle(fontSize: 17.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Please click below for data from previous years. Note: You will be redirected to the CARDI website.",
                              style: TextStyle(fontSize: 17.0),),
                          ),
                          FlatButton(
                          onPressed: _launchURL,
                            child: Text('Archives',
                                style: TextStyle(fontSize: 17.0, color: Colors.lightBlue)),
                          ),
                        ],
                    ),
                  ),
                  ),
                ),

                // Tab 1 TT
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Text("Trinidad and Tobago"),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedCommodityTT,
                                  items: _dropDownMenuTT,
                                  onChanged: changedDropDownItemTT,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonthTT,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItemMonthTT,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            // child: charts.BarChart(_createSampleData(), animate: true),
                            // child: charts.BarChart(_createChartTT("trinidad&tobago", _selectedCommodityTT, _selectedMonthTT), animate: true,),
                            child: charts.BarChart(
                              _loadChartTT(), animate: true,),
                          ),
                          Text("Currency: \$TTD"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Cassava prices were an average of \$7.56TTD per pound. In December 2018, it was an average of \$6.90TTD per pound",
                            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Tab 2 BB
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Text("Barbados"),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedCommodityBB,
                                  items: _dropDownMenuBB,
                                  onChanged: changedDropDownItemBB,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonthBB,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItemMonthBB,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            // child: charts.BarChart(_createSampleData(), animate: true),
                            child: charts.BarChart(_createChartBB(
                                "barbados", _selectedCommodityBB,
                                _selectedMonthBB)),
                          ),
                          Text("Currency: \$BBD"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_getDescription("barbados", _selectedCommodityBB, _selectedMonthBB).getDesc()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Tab 3 GY
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Text("Guyana"),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedCommodityGY,
                                  items: _dropDownMenuGY,
                                  onChanged: changedDropDownItemGY,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonthGY,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItemMonthGY,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
//                            child: charts.BarChart(_createSampleData(), animate: true),
                            child: charts.BarChart(_createChartGY(
                                "guyana", _selectedCommodityGY,
                                _selectedMonthGY)),
                          ),
                          Text("Currency: \$GY"),
                        ],
                      ),
                    ),
                  ),
                ),

                // Tab 4 JA
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Text("Jamaica"),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedCommodityJA,
                                  items: _dropDownMenuJA,
                                  onChanged: changedDropDownItemJA,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonthJA,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItemMonthJA,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
//                            child: charts.BarChart(_createSampleData(), animate: true),
                            child: charts.BarChart(_createChartJA(
                                "jamaica", _selectedCommodityJA,
                                _selectedMonthJA)),
                          ),
                          Text("Currency: \$JCA"),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }

  _launchURL() async {
    const url = 'http://www.cardi.org';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _loadChartTT() {
    return _createChartTT(
        "trinidad&tobago", _selectedCommodityTT, _selectedMonthTT);
  }

  // Function which takes the name of the country, commodity and month and returns a series to build a chart
  List<charts.Series<Data, String>> _createChartTT(String _country,
      String _commodity, String _month) {
    String _date;
    String _price;
    int x;
    List<Data> dataTT = [];

    _commodity = changeCommodity(_commodity);
    _month = changeMonth(_month);

    for (x = 1; x <= 5; x++) {
      // point database to week
      String _week = "week" + x.toString();
      databaseReference = database.reference().child(_country).child(_commodity)
          .child(_month)
          .child(_week);
      // get snapshot
      databaseReference.once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          _date = "";
          _price = "0.0";
        }
        else {
          _date = _week;
          _price = snapshot.value['price'];
          dataTT.add(new Data(_date, double.parse(_price), ""));
        }
      });
    }

    // use data to build a chart series
    return [
      new charts.Series<Data, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Data sales, _) => sales._date,
        measureFn: (Data sales, _) => sales._price,
        data: dataTT,
      )
    ];
  }

  // Function which takes the name of the country, commodity and month and returns a series to build a chart
  List<charts.Series<Data, String>> _createChartBB(String _country,
      String _commodity, String _month) {
    String _date;
    String _price;
    int x;
    List<Data> dataBB = [];

    _commodity = changeCommodity(_commodity);
    _month = changeMonth(_month);

    for (x = 1; x <= 5; x++) {
      // point database to week
      String _week = "week" + x.toString();
      databaseReference = database.reference().child(_country).child(_commodity)
          .child(_month)
          .child(_week);
      // get snapshot
      databaseReference.once().then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          _date = "";
          _price = "0.0";
        }
        else {
          _date = _week;
          _price = snapshot.value['price'];
          dataBB.add(new Data(_date, double.parse(_price), ""));
        }
      });
    }

    // use data to build a chart series
    return [
      new charts.Series<Data, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Data sales, _) => sales._date,
        measureFn: (Data sales, _) => sales._price,
        data: dataBB,
      )
    ];
  }

  // Function which takes the name of the country, commodity and month and returns a series to build a chart
  List<charts.Series<Data, String>> _createChartGY(String _country,
      String _commodity, String _month) {
    String _date;
    String _price;
    int x;
    List<Data> dataGY = [];

    _commodity = changeCommodity(_commodity);
    _month = changeMonth(_month);

    for (x = 1; x <= 5; x++) {
      // point database to week
      String _week = "week" + x.toString();
      databaseReference = database.reference().child(_country).child(_commodity)
          .child(_month)
          .child(_week);
      // get snapshot
      databaseReference.once().then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          _date = "";
          _price = "0.0";
        }
        else {
          _date = _week ;
          _price = snapshot.value['price'];
          dataGY.add(new Data(_date, double.parse(_price), ""));
        }
      });
    }

    // use data to build a chart series
    return [
      new charts.Series<Data, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (Data sales, _) => sales._date,
        measureFn: (Data sales, _) => sales._price,
        data: dataGY,
      )
    ];
  }

  // Function which takes the name of the country, commodity and month and returns a series to build a chart
  List<charts.Series<Data, String>> _createChartJA(String _country,
      String _commodity, String _month) {
    String _date;
    String _price;
    int x;
    List<Data> dataJA = [];

    _commodity = changeCommodity(_commodity);
    _month = changeMonth(_month);

    for (x = 1; x <= 5; x++) {
      // point database to week
      String _week = "week" + x.toString();
      databaseReference = database.reference().child(_country).child(_commodity)
          .child(_month)
          .child(_week);
      // get snapshot
      databaseReference.once().then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          _date = "";
          _price = "0.0";
        }
        else {
          _date = _week;
          _price = snapshot.value['price'];
          dataJA.add(new Data(_date, double.parse(_price), ""));
        }
      });
    }

    // use data to build a chart series
    return [
      new charts.Series<Data, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Data sales, _) => sales._date,
        measureFn: (Data sales, _) => sales._price,
        data: dataJA,
      )
    ];
  }


  // toDo
  // NOT WORKING!!! POSSIBLY USE STREAM BUILDER
  // DATA IS BEING PULLED FROM FIREBASE BUT NOT RETURNED
  // Function which takes the name of the country, commodity and month and returns a description
  Data _getDescription(String _country, String _commodity, String _month) {
    String _description = "No description available";
    _commodity = changeCommodity(_commodity);
    _month = changeMonth(_month);
    Data d = new Data("", 0.0, _description);

    dbRef = database.reference().child(_country).child(_commodity).child(_month).child("description");
      // get snapshot
    dbRef.once().then((DataSnapshot snapshot) {
      if(snapshot.value!= null)
        _description = snapshot.value;
         d = new Data("", 0.0, _description);
         print (d.getDesc()); // correct description !!!
    });

    print(d.getDesc()); // initialized description !!!
    return d;
  }


  String changeCommodity(String _commodity) {
    // match commodity name to value stored in database
    if (_commodity == "Cassava") _commodity = "cassava";
    if (_commodity == "Local dasheen") _commodity = "dasheen";
    if (_commodity == "Imported dasheen") _commodity = "dasheen1";
    if (_commodity == "Local sweet potato") _commodity = "sweetPotato";
    if (_commodity == "Imported sweet potato") _commodity = "sweetPotato1";
    if (_commodity == "Sweet potato") _commodity = "sweetPotato";
    if (_commodity == "Dasheen") _commodity = "dasheen";
    if (_commodity == "Hot pepper") _commodity = "hotPeppers";
    if (_commodity == "Scotch bonnet") _commodity = "scotchBonnet";
    if (_commodity == "West Indian red") _commodity = "westIndianRed";

    return _commodity;
  }

  String changeMonth(String _month) {
    if (_month == "January") _month = "january";
    if (_month == "February") _month = "february";
    if (_month == "March") _month = "march";
    if (_month == "April") _month = "april";
    if (_month == "May") _month = "may";
    if (_month == "June") _month = "june";
    if (_month == "July") _month = "july";
    if (_month == "August") _month = "august";
    if (_month == "September") _month = "september";
    if (_month == "October") _month = "october";
    if (_month == "November") _month = "november";
    if (_month == "December") _month = "december";

    return _month;
  }


  void _onEntryAdded(Event event) {
    setState(() { //anytime a pest is added to firebase, it is added to the pestList and the UI is rebuilt to show the updated list
      // pestList.add(Pest.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
//    var oldEntry = pestList.singleWhere((entry) { //get old key (firebase key for a post)
//      return entry.key == event.snapshot.key;
//    });
//
//    setState(() {
//      pestList[pestList.indexOf(oldEntry)] =
//          Pest.fromSnapshot(event.snapshot);
//    });
  }
}

// Date ending and price of a particular week (one bar on bar chart)
class Data {
  final String _date;
  final double _price;
  final String _description;

  Data(this._date, this._price, this._description);

  String getDate(){
    return _date;
  }

  String getDesc(){
    return _description;
  }

}