import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import 'utils/constants.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: badges.Badge(
              badgeContent: Text('', style: TextStyle(fontFamily: 'Circular', color: wColor,),),
              child: Icon(
                Icons.notifications,
                size: 40,
              ),
            ),
          ),
          InteractiveViewer(child: Image.asset('assets/images/SHefaa.jpg'))
        ],
      ),
    );
  }
}
