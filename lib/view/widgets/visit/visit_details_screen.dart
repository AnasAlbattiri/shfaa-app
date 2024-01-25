import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/screens/lab/laboratory_card.dart';
import 'package:patient_app/view/widgets/visit/pharmacy_card.dart';
import 'package:patient_app/view/screens/rad/radiation_card.dart';


class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({Key? key}) : super(key: key);

  @override
  State<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {

  late int encounterId;

  @override
  void initState() {
    super.initState();
    encounterId = Get.arguments['id'];
  }
  int activeInd = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Orders', style: TextStyle(fontFamily: 'Circular'),),
        backgroundColor: primaryColor.withOpacity(0.95),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              width: 300,
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                groupValue: activeInd,
                children: {
                  0: Text('Laboratory'),
                  1: Text('Radiology'),
                  2: Text('Pharmacy'),
                },
                onValueChanged: (value) {
                  setState(() {
                    activeInd = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if(activeInd == 0)
              LaboratoryCard(encounterId: encounterId,)
            else if (activeInd == 1)
              RadiationCard(encounterId: encounterId,)
            else if (activeInd == 2)
              PharmacyCard(encounterId: encounterId,)
          ],
        ),
      ),
    );
  }
}
