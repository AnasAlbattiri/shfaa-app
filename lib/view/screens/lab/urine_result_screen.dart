import 'package:flutter/material.dart';

class UrineResultScreen extends StatefulWidget {
  const UrineResultScreen({super.key});

  @override
  State<UrineResultScreen> createState() => _UrineResultScreenState();
}

class _UrineResultScreenState extends State<UrineResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urine Result'),

      ),

    );
  }
}
