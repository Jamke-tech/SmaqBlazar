import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IconMap extends StatefulWidget {
  Color iconColor;
  Color borderColor;
  final Function() setStateforMap;
  double size;

  IconMap({super.key, required this.iconColor, required this.borderColor, required this.setStateforMap, required this.size});

  @override
  State<IconMap> createState() => _IconMapState();
}

class _IconMapState extends State<IconMap> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        widget.setStateforMap();
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.iconColor,
            border: Border.all(width: 1,color: widget.borderColor),
        ),
      ),
    );
  }
}