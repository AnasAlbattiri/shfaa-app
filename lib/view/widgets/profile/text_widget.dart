import 'package:flutter/material.dart';
import 'package:patient_app/utils/constants.dart';

Widget textWidget({required String text,double fontSize = 12, FontWeight fontWeight = FontWeight.normal,Color color = Colors.black}){
  return Text(text, style: TextStyle(
    fontFamily: 'Circular',
    fontWeight: FontWeight.bold,
    color: bColor,
  ),);
}