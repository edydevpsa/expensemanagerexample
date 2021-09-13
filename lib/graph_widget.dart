import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//PIE CHART GRAPH WIDGET
class PieGraphWidget extends StatefulWidget {
  final List<double>data;
  
  PieGraphWidget({ Key key, this.data }) : super(key: key);

  @override
  _PieGraphWidgetState createState() => _PieGraphWidgetState();
}

class _PieGraphWidgetState extends State<PieGraphWidget> {

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    var time;
    final measures = <String, double>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum;
      });
    }

    print(time);
    print(measures);

    // Request a build.
    //setState(() {
    //_time = time;
    //_measures = measures;
    //});
  }
  @override
  Widget build(BuildContext context) {
    //var _colorrandom = Colors.primaries[Random().nextInt(10)];
    List<charts.Series<double, num>> series = [
      charts.Series<double, int>(
        id: 'Gasto',
        //colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => index,
        measureFn: (value, _) => value,
        data: widget.data,
        strokeWidthPxFn: (_, __) => 4,
        // fillPatternFn: (value, index) => FillPatternType.forwardHatch,
        //fillColorFn: (__,_) => Color(r: 0, g: 79, b: 99, a: 123),
        

      )
    ];
    return charts.PieChart(
      series,
      // selectionModels: [
      //   charts.SelectionModelConfig(
      //     type: charts.SelectionModelType.info,
      //     changedListener: _onSelectionChanged,
      //   )
      // ],
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 60,
        // arcRendererDecorators: [
        //   charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.auto),
        // ],
      ),
      animate: true,
      // selectionModels: [
      //   SelectionModelConfig(
      //     type: SelectionModelType.info,
      //     changedListener: _onSelectionChanged,
      //   )
      // ],
      // layoutConfig: LayoutConfig(leftMarginSpec: MarginSpec.defaultSpec, topMarginSpec: MarginSpec.fixedPixel(30), rightMarginSpec: MarginSpec.fixedPixel(40), bottomMarginSpec: MarginSpec.fixedPixel(50)),
    );
  }
}

//LINES CHART GRAPH WIDGET
class LinesGraphWidget extends StatefulWidget {
  final List<double>data;

  LinesGraphWidget({Key key, this.data}) : super(key: key);
  @override
  _LinesGraphWidgetState createState() => _LinesGraphWidgetState();
}

class _LinesGraphWidgetState extends State<LinesGraphWidget> {
  // var data;
  // @override
  // void initState() {
  //   super.initState();

  //   var r = Random();
  //   data = List<double>.generate(30, (i) => r.nextDouble() * 1500);
  // }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    var time;
    final measures = <String, double>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum;
      });
    }

    print(time);
    print(measures);

    // Request a build.
    //setState(() {
    //_time = time;
    //_measures = measures;
    //});
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<double, num>> series = [
      charts.Series<double, int>(
        id: 'Gasto',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (value, index) => index,
        measureFn: (value, _) => value,
        data: widget.data,
        strokeWidthPxFn: (_, __) => 4,
      )
    ];

    return charts.LineChart(
      series,
      animate: false,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      domainAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
              [
                charts.TickSpec(0, label: '01'),
                charts.TickSpec(4, label: '05'),
                charts.TickSpec(9, label: '10'),
                charts.TickSpec(14, label: '15'),
                charts.TickSpec(19, label: '20'),
                charts.TickSpec(24, label: '25'),
                charts.TickSpec(29, label: '30'),
              ]
          )
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 4,
        ),
      ),
    );
  }
}

//BAR GRAPH WIDGET
class BarGraphWidget extends StatefulWidget {
  final List<double>data;
  BarGraphWidget({ Key key, this.data }) : super(key: key);

  @override
  _BarGraphWidgetState createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {


  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    var time;
    final measures = <String, double>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum;
      });
    }

    print(time);
    print(measures);

    // Request a build.
    //setState(() {
    //_time = time;
    //_measures = measures;
    //});
    // return Container(
    //   height: 20.0,
    //   width: 30.0,
    //   child: Text(measures.toString()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // List<Series<double, num>> series = [
    //   Series<double, int>(
    //     id: 'Gasto',
    //     colorFn: (_, __) => MaterialPalette.indigo.shadeDefault,
    //     domainFn: (value, index) => index,
    //     measureFn: (value, _) => value,
    //     data: widget.data,
    //     strokeWidthPxFn: (_, __) => 4,
    //   )
    // ];

    List<charts.Series<dynamic, String>>seriesList = [
      charts.Series<dynamic, String>(
        id: 'Gasto',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (value, index) => index.toString(),
        measureFn: (value, _) => value,
        data: widget.data,
        strokeWidthPxFn: (_, __) => 4,
      ),

    ];
    return charts.BarChart(
      seriesList,
      animate: false,
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
      // domainAxis: NumericAxisSpec(
      //     tickProviderSpec: StaticNumericTickProviderSpec(
      //         [
      //           TickSpec(0, label: '01'),
      //           TickSpec(4, label: '05'),
      //           TickSpec(9, label: '10'),
      //           TickSpec(14, label: '15'),
      //           TickSpec(19, label: '20'),
      //           TickSpec(24, label: '25'),
      //           TickSpec(29, label: '30'),
      //         ]
      //     )
      // ),
      // primaryMeasureAxis: NumericAxisSpec(
      //   tickProviderSpec: BasicNumericTickProviderSpec(
      //     desiredTickCount: 4,
      //   ),
      // ),
      domainAxis: charts.AxisSpec<String>(
        tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
          [
                charts.TickSpec('0', label: '01'),
                charts.TickSpec('4', label: '05'),
                charts.TickSpec('9', label: '10'),
                charts.TickSpec('14', label: '15'),
                charts.TickSpec('19', label: '20'),
                charts.TickSpec('24', label: '25'),
                charts.TickSpec('29', label: '30'),
          ]
        ),
      ),
      // primaryMeasureAxis: OrdinalAxisSpec(
      //   tickProviderSpec: BasicOrdinalTickProviderSpec(),
      // ),
    );
  }
}