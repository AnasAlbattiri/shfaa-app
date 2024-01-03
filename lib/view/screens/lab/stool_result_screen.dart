import 'package:flutter/material.dart';

class StoolResultScreen extends StatefulWidget {
  const StoolResultScreen({super.key});

  @override
  State<StoolResultScreen> createState() => _StoolResultScreenState();
}

class _StoolResultScreenState extends State<StoolResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stool Result'),

      ),

    );
  }
}
