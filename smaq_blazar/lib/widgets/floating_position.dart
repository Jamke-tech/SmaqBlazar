import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/station_model.dart';

class FloatPosition extends StatefulWidget {
  Function() functionWhenClicked;
  bool isRefresh = false;

  FloatPosition(
      {super.key,required this.functionWhenClicked, required this.isRefresh});

  @override
  State<FloatPosition> createState() => _FloatPositionState();
}

class _FloatPositionState extends State<FloatPosition> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.blueGrey.shade200,
        onPressed: widget.functionWhenClicked,
      child: !widget.isRefresh ? const Icon(Icons.my_location_outlined,color: Colors.black):const Icon(Icons.refresh_outlined,color: Colors.black,) ,
    );

  }
}
