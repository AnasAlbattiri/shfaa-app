import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/widgets/nav/upcoming_card.dart';

import '../../../logic/controller/upcoming_controller.dart';
import '../../widgets/nav/visits_card.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);


  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.95),
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/visits.png',
                width: 42,
                fit: BoxFit.cover,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(width: 14),
            Text('Appointments / Visits', style: TextStyle(fontFamily: 'Circular', fontSize: 18 ),),
          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 300,
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                groupValue: activeIndex,
                children: {
                  0: Text('Upcoming appt.'),
                  1: Text('Visits prev.'),
                },
                onValueChanged: (value) {
                  setState(() {
                    activeIndex = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            activeIndex == 0 ? UpcomingCard() : VisitsCard(),

          ],
        ),
      ),
    );
  }
}
