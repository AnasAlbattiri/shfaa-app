import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/logic/controller/upcoming_controller.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/laboratory_controller.dart';

class LaboratoryCard extends StatefulWidget {
  final int encounterId;
  LaboratoryCard({Key? key, required this.encounterId,}) : super(key: key);

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
                    0: Text('Active'),
                    1: Text('Pending'),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      laboratoryController.activeIndex = value!;

                      // Update printFlag based on activeIndex
                      laboratoryController.updatePrintFlag(widget.encounterId);
                    });
                  },
                ),
              ),
              laboratoryController.activeIndex == 0 ? laboratoryList(laboratoryController: laboratoryController) : laboratoryList(laboratoryController: laboratoryController),

              SizedBox(height: 10,),
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

class laboratoryList extends StatelessWidget {
  const laboratoryList({
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
                            SizedBox(
                              height: 25,
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
        itemCount: laboratoryController.laboratories.length,
      ),
    );
  }
}
