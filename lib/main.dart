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

  List _commoditiesTT = ["Cassava", "Local Dasheen", "Imported Dasheen", "Local sweet pepper", "Imported sweet pepper", "Hot pepper"];
  List _commoditiesJA = ["Dasheen", "Sweet pepper", "Hot pepper"];
  List _commoditiesBB = ["Cassava", "Sweet pepper", "Hot pepper"];
  List _commoditiesGY = ["Cassava", "Sweet pepper", "Hot pepper"];
  List _months = ["January", "February", "March", "April", "May"];

  List<DropdownMenuItem<String>> _dropDownMenuBB;
  List<DropdownMenuItem<String>> _dropDownMenuGY;
  List<DropdownMenuItem<String>> _dropDownMenuTT;
  List<DropdownMenuItem<String>> _dropDownMenuJA;
  List<DropdownMenuItem<String>> _dropDownMenuMonths;

  String _selectedCommodity;
  String _selectedMonth;

  @override
  void initState() {

    _dropDownMenuBB = buildAndGetDropDownMenuItems(_commoditiesBB);
    _dropDownMenuTT = buildAndGetDropDownMenuItems(_commoditiesTT);
    _dropDownMenuGY = buildAndGetDropDownMenuItems(_commoditiesGY);
    _dropDownMenuJA = buildAndGetDropDownMenuItems(_commoditiesJA);
    _dropDownMenuMonths = buildAndGetDropDownMenuItems(_months);

    _selectedCommodity = "Hot pepper";
    _selectedMonth = "January";

    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selected) {
    setState(() {
      _selectedMonth = selected;
    });
  }

  void changedDropDownItem2(String selectedCommodity) {
    setState(() {
      _selectedCommodity = selectedCommodity;
    });
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
          length: 4,
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
              leading: Image.asset("assets/logo.png"),
              title: Text('MARKET ANALYSIS', style: TextStyle(color: Colors.green),),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: TabBarView(
              children: [
                // Tab 1
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
                                  value: _selectedCommodity,
                                  items: _dropDownMenuTT,
                                  onChanged: changedDropDownItem2,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonth,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItem,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: charts.BarChart(_createSampleData(), animate: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Tab 2
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
                                  value: _selectedCommodity,
                                  items: _dropDownMenuBB,
                                  onChanged: changedDropDownItem2,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonth,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItem,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: charts.BarChart(_createSampleData(), animate: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Tab 3
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
                                value: _selectedCommodity,
                                items: _dropDownMenuGY,
                                onChanged: changedDropDownItem2,
                              ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonth,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItem,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: charts.BarChart(_createSampleData(), animate: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Tab 4
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
                                  value: _selectedCommodity,
                                  items: _dropDownMenuJA,
                                  onChanged: changedDropDownItem2,
                                ),
                              ),
                              Expanded(
                                child: new DropdownButton(
                                  value: _selectedMonth,
                                  items: _dropDownMenuMonths,
                                  onChanged: changedDropDownItem,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: charts.BarChart(_createSampleData(), animate: true),
                          ),
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

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Week 1', 20),
      new OrdinalSales('Week 2', 25),
      new OrdinalSales('Week 3', 30),
      new OrdinalSales('Week 4', 25),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}