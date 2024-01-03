import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/all_labs_controller.dart';
import '../../../logic/controller/laboratory_controller.dart';

class AllLabsScreen extends StatefulWidget {
  AllLabsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllLabsScreen> createState() => _AllLabsScreenState();
}

class _AllLabsScreenState extends State<AllLabsScreen> {
  late AllLabsController allLabsController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    allLabsController = Get.put(AllLabsController(patientId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'All laboratories',
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
                          groupValue: allLabsController.activeIndex,
                          children: {
                            0: Text('Active'),
                            1: Text('Pending'),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              final int patientId = Get.arguments['patientId'];
                              allLabsController.activeIndex = value!;
                              allLabsController.updatePrintFlag(patientId);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: allLabsController.allLabs.isEmpty
                            ? Center(
                          child: Text(
                            (allLabsController.activeIndex == 0)
                                ? 'No Active laboratories found'
                                : 'No Pending laboratories found',
                          ),
                        )
                            : laboratoryList(allLabsController: allLabsController),
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

class laboratoryList extends StatelessWidget {
  const laboratoryList({
    super.key,
    required this.allLabsController,
  });

  final AllLabsController allLabsController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final allLab = allLabsController.allLabs[index];
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
                        '${allLab.servDesc}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        'Dr.${allLab.doctorName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Circular',
                          color: wColor,
                        ),
                      ),
                      Text(
                        '${allLab.listFormate}',
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
                                '${allLab.orderDateStr}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Circular'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${allLab.str}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Circular',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                              width: 75,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {},
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
                  )
                ],
              ),
            ),
          );
        },
        itemCount: allLabsController.allLabs.length,
      ),
    );
  }
}
