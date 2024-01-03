import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class CbcResultScreen extends StatefulWidget {
  const CbcResultScreen({super.key});

  @override
  State<CbcResultScreen> createState() => _CbcResultScreenState();
}

class _CbcResultScreenState extends State<CbcResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'CBC Result',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            children: [
              buildRow(['Name', 'Result', 'Unit', 'List'], isHeader: true,),
              buildRow(['Name', 'Result', 'Unit', 'List']),
              buildRow(['Name', 'Result', 'Unit', 'List']),
              buildRow(['Name', 'Result', 'Unit', 'List']),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    children: cells.map((cell) {
      TextStyle style = TextStyle(
        fontSize: 18,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      );
      return Padding(
          padding: EdgeInsets.all(12), child: Text(cell, style: style));
    }).toList(),
  );

}
