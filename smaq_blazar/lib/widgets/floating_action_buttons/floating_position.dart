import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../classes/Model/station_model.dart';

class FloatPosition extends StatefulWidget {
  Function() functionWhenClicked;
  bool isPlane = false;
  bool isPlaneOff = true;
  bool isFilter = false;

  FloatPosition(
      {super.key,
      required this.functionWhenClicked,
      required this.isPlane,
      required this.isPlaneOff,
      required this.isFilter});

  @override
  State<FloatPosition> createState() => _FloatPositionState();
}

class _FloatPositionState extends State<FloatPosition> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: widget.isPlane? "planeBTN" : widget.isFilter? "filterBTN" : "positionBTN",
      backgroundColor: Colors.blueGrey.shade200.withOpacity(0.8),
      hoverColor: const Color(0xff00877F),
      splashColor: const Color(0xff00877F),
      onPressed: widget.functionWhenClicked,
      child: !widget.isPlane
          ? const Icon(Icons.my_location_outlined,
              color: Color(0xff00877F))
          : !widget.isFilter ? (!widget.isPlaneOff
              ? const Icon(Icons.airplanemode_inactive_outlined,
                  color: Color(0xff00877F))
              : const Icon(
                  Icons.airplanemode_active_outlined,
                  color: Color(0xff00877F),
      )) : const Icon(Icons. filter_alt_off_rounded,
      color: Color(0xff00877F) ),
    );
  }
}
