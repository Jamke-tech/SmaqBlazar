import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IconMap extends StatelessWidget {
  MaterialColor Iconcolor;

  IconMap({super.key, required this.Iconcolor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Iconcolor,
          border: Border.all(width: 3,color: Colors.black),
      ),
      child: TextButton(
        onPressed: (){
          print("Icon pressed and screen show");

        }, child: Text("35"),

      )


    );
  }
}