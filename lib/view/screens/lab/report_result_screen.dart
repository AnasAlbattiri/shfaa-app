import 'package:flutter/material.dart';

class ReportResultScreen extends StatefulWidget {
  const ReportResultScreen({super.key});

  @override
  State<ReportResultScreen> createState() => _ReportResultScreenState();
}

class _ReportResultScreenState extends State<ReportResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Report Result'),

      ),

    );
  }
}
