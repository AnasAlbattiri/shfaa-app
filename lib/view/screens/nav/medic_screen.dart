import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/logic/controller/medic_controller.dart';
import '../../../utils/constants.dart';

class MedicScreen extends StatefulWidget {
  const MedicScreen({Key? key}) : super(key: key);

  @override
  State<MedicScreen> createState() => _MedicScreenState();
}

class _MedicScreenState extends State<MedicScreen> {
  late MedicController medicController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    medicController = Get.put(MedicController(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/medic.png',
              height: 40,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              'Chronic Medications',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 20,
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
              if (medicController.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              } else if (medicController.medics.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final medic = medicController.medics[index];
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
                                  'assets/images/medic.png',
                                  width: 35,
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
                                      '${medic.servDesc} / ${medic.dosageNumber} ${medic.counter}',
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      medic.str5,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      '${medic.instraction} / ${medic.str3}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      '${medic.str4}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      'Start Date: ${medic.str}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      'End Date: ${medic.str2}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      medic.desc,
                                      style: TextStyle(
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      '# of refills: ${medic.value3}',
                                      style: TextStyle(
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${medic.quantity}',
                                      style: TextStyle(
                                        color: wColor,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Divider(
                                      color: wColor,
                                      height: 20,
                                      thickness: 1,
                                    ),
                                    Text(
                                      '${medic.notes}',
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
                    itemCount: medicController.medics.length,
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text(
                      'No Medicines Found',
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

