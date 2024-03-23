import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/logic/controller/pharm/all_pharmacy_controller.dart';
import 'package:patient_app/logic/controller/pharm/pharmacy_controller.dart';
import 'package:patient_app/utils/constants.dart';

class AllPharmacyScreen extends StatefulWidget {
  const AllPharmacyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllPharmacyScreen> createState() => _AllPharmacyScreenState();
}

class _AllPharmacyScreenState extends State<AllPharmacyScreen> {
  late AllPharmacyController allPharmacyController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];

    allPharmacyController = Get.put(AllPharmacyController(patientId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'Pharmacy',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      child: CupertinoSlidingSegmentedControl(
                        padding: const EdgeInsets.all(5),
                        groupValue: allPharmacyController.activeIndex,
                        children: {
                          0: Text('Active'),
                          1: Text('Pending'),
                        },
                        onValueChanged: (value) {
                          setState(() {
                            final int patientId = Get.arguments['patientId'];

                            allPharmacyController.activeIndex = value!;

                            // Update printFlag based on activeIndex
                            allPharmacyController.updatePrintFlag(patientId);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: allPharmacyController.pharmacy.isEmpty
                          ? Center(
                        child: Text(
                          (allPharmacyController.activeIndex == 0)
                              ? 'No Active pharmacy found'
                              : 'No Pending pharmacy found',
                        ),
                      )
                          : pharmacyList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget pharmacyList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final pharmacy = allPharmacyController.pharmacy[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                    'assets/images/pharm.png',
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
                        pharmacy.servDesc,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Circular',
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        '${pharmacy.dosageNo} ${pharmacy.desc1} ${pharmacy.counter}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Circular',
                          color: wColor,
                        ),
                      ),
                      Text(
                        'Dr.${pharmacy.doctorName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Circular',
                          color: wColor,
                        ),
                      ),
                      Text(
                        pharmacy.desc,
                        style: TextStyle(
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 25,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
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
                              padding: EdgeInsets.only(left: 6, right: 12),
                              child: Text(
                                '${pharmacy.dosageStartDateStr}  ${pharmacy.str}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Circular',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: wColor,
                        height: 20,
                        thickness: 1,
                      ),
                      Text(
                        '${pharmacy.notes}',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
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
      itemCount: allPharmacyController.pharmacy.length,
    );
  }
}
