import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/screens/lab/cbc_result_screen.dart';
import 'package:patient_app/view/screens/lab/culture_result_screen.dart';
import 'package:patient_app/view/screens/lab/other_result_screen.dart';
import 'package:patient_app/view/screens/lab/report_result_screen.dart';
import 'package:patient_app/view/screens/lab/seminal_result_screen.dart';
import 'package:patient_app/view/screens/lab/stool_result_screen.dart';
import 'package:patient_app/view/screens/lab/urine_result_screen.dart';
import '../../../logic/controller/laboratory_controller.dart';

class LaboratoryCard extends StatefulWidget {
  final int encounterId;
  LaboratoryCard({
    Key? key,
    required this.encounterId,
  }) : super(key: key);

  @override
  State<LaboratoryCard> createState() => _LaboratoryCardState();
}

class _LaboratoryCardState extends State<LaboratoryCard> {
  late LaboratoryController laboratoryController;

  @override
  void initState() {
    super.initState();
    laboratoryController = Get.put(LaboratoryController(widget.encounterId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (laboratoryController.isLoading.isTrue) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (laboratoryController.laboratories.isNotEmpty) {
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 300,
                child: CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(5),
                  groupValue: laboratoryController.activeIndex,
                  children: {
                    0: Text('Resulted'),
                    1: Text('Pending'),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      laboratoryController.activeIndex = value!;
                      laboratoryController.updatePrintFlag(widget.encounterId);
                    });
                  },
                ),
              ),
              Expanded(
                child: laboratoryController.laboratories.isEmpty
                    ? Center(
                        child: Text(
                          (laboratoryController.activeIndex == 0)
                              ? 'No Active laboratories found'
                              : 'No Pending laboratories found',
                        ),
                      )
                    : laboratoryController.activeIndex == 0 ? LaboratoryActiveList(
                    laboratoryController: laboratoryController) : LaboratoryPendingList(laboratoryController: laboratoryController),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Text(
            'No Laboratory Found',
            style: TextStyle(
              color: bColor,
              fontFamily: 'Circular',
            ),
          ),
        );
      }
    });
  }
}

class LaboratoryActiveList extends StatelessWidget {
  const LaboratoryActiveList({
    super.key,
    required this.laboratoryController,
  });

  final LaboratoryController laboratoryController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final laboratory = laboratoryController.laboratories[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Container(
              width: double.maxFinite,
              height: 175,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.80),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/lab.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          laboratory.servDesc,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontFamily: 'Circular',
                          ),
                        ),
                        Text(
                          'Dr.${laboratory.doctorName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Circular',
                            color: wColor,
                          ),
                        ),
                        Text(
                          laboratory.listFormate,
                          style: TextStyle(
                            fontFamily: 'Circular',
                            fontSize: 14,
                            color: wColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.calendar_outline,
                                size: 18,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                child: Text(
                                  '${laboratory.orderDateStr}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Circular'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  '${laboratory.str}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Circular',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                width: 75,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (laboratory.labTestCat == 1) {
                                      if (laboratory.profileId == 8) {
                                        Get.to(UrineResultScreen());
                                      } else if (laboratory.profileId == 12) {
                                        Get.to(StoolResultScreen());
                                      } else if (laboratory.profileId == 17) {
                                        Get.to(SeminalResultScreen());
                                      } else if (laboratory.labTestResultType == 1 ||
                                          laboratory.labTestResultType == 2 ||
                                          laboratory.labTestResultType == 4 ||
                                          laboratory.labTestResultType == 6) {
                                        Get.to(OtherResultScreen());
                                      } else if (laboratory.labTestResultType == 5) {
                                        Get.to(CultureResultScreen());
                                      } else if (laboratory.labTestResultType == 3) {
                                        Get.to(ReportResultScreen());
                                      }
                                    } else if (laboratory.labTestCat == 3) {
                                      Get.to(CbcResultScreen());
                                    }
                                  },
                                  child: const Text(
                                    'Results',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: wColor,
                                      fontFamily: 'Circular',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: laboratoryController.laboratories.length,
      ),
    );
  }
}

class LaboratoryPendingList extends StatelessWidget {
  const LaboratoryPendingList({
    super.key,
    required this.laboratoryController,
  });

  final LaboratoryController laboratoryController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final laboratory = laboratoryController.laboratories[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Container(
              width: double.maxFinite,
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.80),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/lab.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        laboratory.servDesc,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        'Dr.${laboratory.doctorName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Circular',
                          color: wColor,
                        ),
                      ),
                      Text(
                        laboratory.listFormate,
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 14,
                          color: wColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.calendar_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 6),
                              child: Text(
                                '${laboratory.orderDateStr}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Circular'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${laboratory.str}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Circular',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: laboratoryController.laboratories.length,
      ),
    );
  }
}
