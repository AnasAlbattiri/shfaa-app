import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/all_labs_controller.dart';
import '../../../logic/controller/lab_results_controller.dart';
import '../../../logic/controller/laboratory_controller.dart';
import '../lab/other_result_screen.dart';

class AllLabsScreen extends StatefulWidget {
  final int encounterId;

  AllLabsScreen({
    Key? key, required this.encounterId,
  }) : super(key: key);

  @override
  State<AllLabsScreen> createState() => _AllLabsScreenState();
}

class _AllLabsScreenState extends State<AllLabsScreen> {
  late AllLabsController allLabsController;
  late LaboratoryController laboratoryController;
  late LaboratoryResultsController laboratoryResultsController;


  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    allLabsController = Get.put(AllLabsController(patientId, 1));
    laboratoryController = Get.put(LaboratoryController(widget.encounterId, 1));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'All laboratory',
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (allLabsController.isLoading.isTrue) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (allLabsController.allLabs.isNotEmpty) {
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
                            : laboratoryController.activeIndex == 0
                            ? LaboratoryActiveList(
                            laboratoryController: laboratoryController)
                            : LaboratoryPendingList(
                          laboratoryController: laboratoryController,),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'No Labs Found',
                    style: TextStyle(
                      color: bColor,
                      fontFamily: 'Circular',
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
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
          Map<String, dynamic> arguments = {
            'orderId': laboratory.orderId,
            'orderDtlId': laboratory.id,
            'testCat': laboratory.labTestCat,
            'resultType': laboratory.labTestResultType,
            'profileId': laboratory.profileId,
            'siteId': laboratory.siteId,
          };

          Map<String, dynamic> otherArguments = {
            'orderId': laboratory.orderId,
            'orderDtlId': laboratory.id,
            'testCat': laboratory.labTestCat,
            'resultType': laboratory.labTestResultType,
            'profileId': laboratory.profileId,
            'siteId': laboratory.siteId,
            'labTestId': laboratory.labTestId,
            'machineId': laboratory.machineId,
            'machineKitId': laboratory.machineKitId,
            'value4': laboratory.value4,
          };
          return Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Container(
              width: double.maxFinite,
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
                                height: 18,
                                width: 70,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => OtherResultScreen(), arguments: otherArguments);
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
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onPrimary,
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
