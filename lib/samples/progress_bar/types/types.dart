///Dart imports
import 'dart:async';

///Package imports
import 'package:flutter/material.dart';

///gauges import
import 'package:syncfusion_flutter_gauges/gauges.dart';

///Local import
import '../../../model/sample_view.dart';

/// Widget of the AgendaView Calendar.
class ProgressBarTypes extends SampleView {
  /// Cr
  const ProgressBarTypes(Key key) : super(key: key);

  @override
  _ProgressBarTypesState createState() => _ProgressBarTypesState();
}

class _ProgressBarTypesState extends SampleViewState {
  _ProgressBarTypesState();

  double _size = 150;
  Timer _timer;
  double _value = 0;
  double _value1 = 0;
  double _value2 = 0;
  double _endValue = 20;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer _timer) {
        setState(() {
          _value++;

          if (!_isLoaded || (_isLoaded && _value1 > 0 && _value1 != 100)) {
            _value1++;
          }

          if (_endValue != 100) {
            _endValue++;
          }

          if ((_value1 > 20 && !_isLoaded) ||
              (_isLoaded && ((_value2 - _value1).abs() == 20) ||
                  _value1 == 100)) {
            _value2++;
          }

          if (_value == 100) {
            _value = 0;
          }
          if (_value1 == 100) {
            _isLoaded = true;
          }

          if (_value2 == 100) {
            _value2 = 0;
            _value1 = 0;
            _value1++;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getWidget(MediaQuery.of(context).size),
    );
  }

  Widget _getWidget(Size size) {
    if (size.width > size.height) {
      _size = size.width / 4.5;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getDeterminateProgressBar(),
                Center(child: Text('Determinate')),
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getBufferProgressBar(),
                Center(child: Text('Buffer')),
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getSegmentProgressBar(),
                Center(child: Text('Segment'))
              ]),
        ],
      );
    } else {
      _size = model.isWeb ? size.height / 5 : size.height / 4.5;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getDeterminateProgressBar(),
          Center(child: Text('Determinate')),
          _getBufferProgressBar(),
          Center(child: Text('Buffer')),
          _getSegmentProgressBar(),
          Center(child: Text('Segment'))
        ],
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _getDeterminateProgressBar() {
    return Container(
      height: _size,
      width: _size,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          startAngle: 270,
          endAngle: 270,
          showLabels: false,
          showTicks: false,
          radiusFactor: model.isWeb ? 0.7 : 0.75,
          axisLineStyle: AxisLineStyle(
            thickness: 0.05,
            color: const Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
                value: _value,
                width: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 20,
                animationType: AnimationType.linear)
          ],
        )
      ]),
    );
  }

  Widget _getBufferProgressBar() {
    return Container(
      height: _size,
      width: _size,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          canScaleToFit: true,
          radiusFactor: model.isWeb ? 0.7 : 0.8,
          axisLineStyle: AxisLineStyle(
            thickness: 0.05,
            color: const Color.fromARGB(20, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
                value: _value1,
                width: 0.05,
                color: const Color.fromARGB(90, 0, 169, 181),
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 20,
                animationType: AnimationType.linear),
            RangePointer(
                value: _value2,
                width: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 20,
                animationType: AnimationType.linear)
          ],
        )
      ]),
    );
  }

  Widget _getSegmentProgressBar() {
    return Container(
        height: _size,
        width: _size,
        child: SfRadialGauge(axes: <RadialAxis>[
          // Create primary radial axis
          RadialAxis(
            interval: 25,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: model.isWeb ? 0.7 : 0.8,
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              color: const Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: _value,
                  width: 0.05,
                  pointerOffset: 0.07,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 20,
                  animationType: AnimationType.linear)
            ],
          ),
          // Create secondary radial axis for segmented line
          RadialAxis(
            interval: 25,
            showLabels: false,
            showTicks: true,
            showAxisLine: false,
            tickOffset: -0.05,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 0,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: model.isWeb ? 0.7 : 0.8,
            majorTickStyle: MajorTickStyle(
                length: 0.3,
                thickness: 3,
                lengthUnit: GaugeSizeUnit.factor,
                color: model.currentThemeData.brightness == Brightness.light
                    ? Colors.white
                    : Color.fromRGBO(33, 33, 33, 1)),
          )
        ]));
  }
}
