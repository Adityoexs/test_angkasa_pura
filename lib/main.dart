import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var passenger = [
      Quantity("Sun", 70 , Colors.red),
      Quantity("Mon", 170, Colors.orange),
      Quantity("Tue", 150, Colors.yellow),
      Quantity("Wed", 150, Colors.green),
      Quantity("Thu", 45, Colors.blue),
      Quantity("Fri", 100, Colors.amberAccent),
      Quantity("Sat", 200, Colors.purple),
    ];

    var foreignPassenger = [
      Quantity("Sun", 50, Colors.red.shade200),
      Quantity("Mon", 70, Colors.orange.shade200),
      Quantity("Tue", 100, Colors.yellow.shade200),
      Quantity("Wed", 50, Colors.green.shade200),
      Quantity("Thu", 145, Colors.blue.shade200),
      Quantity("Fri", 100, Colors.amberAccent.shade200),
      Quantity("Sat", 50, Colors.purple.shade200),
    ];

    var series = [
      charts.Series(
        domainFn: (Quantity quantity, _) => quantity.day,
        measureFn: (Quantity quantity, _) => quantity.sold,
        colorFn: (Quantity quantity, _) => quantity.color,
        id: 'Local Quantity',
        data: passenger,
        labelAccessorFn: (Quantity quantity, _) =>
            '${quantity.day} : ${quantity.sold.toString()}',
      ),
      charts.Series(
        domainFn: (Quantity quantity, _) => quantity.day,
        measureFn: (Quantity quantity, _) => quantity.sold,
        colorFn: (Quantity quantity, _) => quantity.color,
        id: 'Foreign Quantity',
        data: foreignPassenger,
        labelAccessorFn: (Quantity quantity, _) =>
            '${quantity.day} : ${quantity.sold.toString()}',
      ),
    ];

    var chart = charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.grouped,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Graph"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              "Angkasa Pura Revenue",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 400,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }
}

class Quantity {
  final String day;
  final int sold;
  final charts.Color color;

  Quantity(this.day, this.sold, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}