/// Package imports
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../model/sample_view.dart';
import '../../../../widgets/custom_dropdown.dart';

/// Renders the line chart with category label placement sample.
class CategoryTicks extends SampleView {
  /// Creates the arrange by index category axis chart sample.
  const CategoryTicks(Key key) : super(key: key);

  @override
  _CategoryTicksState createState() => _CategoryTicksState();
}

/// State class of the line chart with category label placement.
class _CategoryTicksState extends SampleViewState {
  _CategoryTicksState();
  final List<String> _labelPosition =
      <String>['betweenTicks', 'onTicks'].toList();
  String _selectedType;
  LabelPlacement _labelPlacement;

  @override
  void initState() {
    _selectedType = 'betweenTicks';
    _labelPlacement = LabelPlacement.betweenTicks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getTicksCategoryAxisChart();
  }

  @override
  Widget buildSettings(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Label placement ',
                style: TextStyle(
                    color: model.textColor,
                    fontSize: 16,
                    letterSpacing: 0.34,
                    fontWeight: FontWeight.normal)),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                height: 50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: model.bottomSheetBackgroundColor),
                    child: DropDown(
                        value: _selectedType,
                        item: _labelPosition.map((String value) {
                          return DropdownMenuItem<String>(
                              value: (value != null) ? value : 'betweenTicks',
                              child: Text('$value',
                                  style: TextStyle(color: model.textColor)));
                        }).toList(),
                        valueChanged: (dynamic value) {
                          _onPositionTypeChange(value.toString());
                        }),
                  ),
                )),
          ],
        ),
      ],
    );
  }

  /// Returns the line chart with category label placement.
  SfCartesianChart _getTicksCategoryAxisChart() {
    return SfCartesianChart(
      title: ChartTitle(text: isCardView ? '' : 'Employees task count'),
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: _labelPlacement),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          minimum: 7,
          maximum: 12,
          interval: 1),
      series: _getTicksCategoryAxisSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// Returns the list of chart series which need to render on the line chart.
  List<LineSeries<ChartSampleData, String>> _getTicksCategoryAxisSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'John', yValue: 10),
      ChartSampleData(x: 'Parker', yValue: 11),
      ChartSampleData(x: 'David', yValue: 9),
      ChartSampleData(x: 'Peter', yValue: 10),
      ChartSampleData(x: 'Antony', yValue: 11),
      ChartSampleData(x: 'Brit', yValue: 10)
    ];
    return <LineSeries<ChartSampleData, String>>[
      LineSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.yValue,
          markerSettings: MarkerSettings(isVisible: true))
    ];
  }

  /// Method for changing the label placement
  /// for the category axis in the line chart.
  void _onPositionTypeChange(String item) {
    _selectedType = item;
    if (_selectedType == 'betweenTicks') {
      _labelPlacement = LabelPlacement.betweenTicks;
    }
    if (_selectedType == 'onTicks') {
      _labelPlacement = LabelPlacement.onTicks;
    }
    setState(() {
      /// update the label placement type change
    });
  }
}
