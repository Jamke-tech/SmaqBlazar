import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IconMap extends StatefulWidget {
  Color Iconcolor;
  final Function() setStateforMap;

  IconMap({super.key, required this.Iconcolor, required this.setStateforMap});

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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.Iconcolor,
            border: Border.all(width: 2,color: Colors.black),
        ),
      ),
    );
  }
}