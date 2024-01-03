import 'package:flutter/material.dart';

class CultureResultScreen extends StatefulWidget {
  const CultureResultScreen({super.key});

  @override
  State<CultureResultScreen> createState() => _CultureResultScreenState();
}

class _CultureResultScreenState extends State<CultureResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culture Result'),

      ),

    );
  }
}
