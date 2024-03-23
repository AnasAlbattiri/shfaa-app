import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controller/drawer/vitals_controller.dart';
import '../../../utils/constants.dart';

class VitalsScreen extends StatefulWidget {
  const VitalsScreen({Key? key}) : super(key: key);

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  late VitalsController vitalsController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    vitalsController = Get.put(VitalsController(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'Vital signs',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: wColor,
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (vitalsController.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              } else if (vitalsController.vitals.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final vital = vitalsController.vitals[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
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
                                  'assets/images/vital.png',
                                  width: 37,
                                  height: 40,
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
                                      'Temperature(C): ${vital.temperature}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      'Blood pressure(mmHg): ${vital.pressureLow} / ${vital.pressureHigh}',
                                      // '${medic.str4}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      'Oxygen SAT %: ${vital.oxeginRate}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      'Heart rate(Beat/min): ${vital.heartBeatNo}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      'Respiratory rate(Breath): ${vital.breathNo}',
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      'Institute: ${vital.siteDesc}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month, color: Colors.yellow, size: 16,),

                                        Text(
                                          ' ${vital.str} ',
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontFamily: 'Circular',

                                          ),
                                        ),
                                        Icon(Icons.access_time_filled, color: Colors.yellow, size: 16,),

                                        Text(
                                          ' ${vital.str2}',
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontFamily: 'Circular',

                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: vitalsController.vitals.length,
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text(
                      'No Vitals Found',
                      style: TextStyle(color: bColor),
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

