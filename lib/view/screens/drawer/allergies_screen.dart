import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/logic/controller/drawer/allergies_controller.dart';
import '../../../utils/constants.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({Key? key}) : super(key: key);

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  late AllergiesController allergiesController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    allergiesController = Get.put(AllergiesController(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'Allergies',
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
              if (allergiesController.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              } else if (allergiesController.allergies.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final allergie = allergiesController.allergies[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Container(
                          width: double.maxFinite,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                                  'assets/images/allergie.png',
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
                                      allergie.result,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        fontFamily: 'Circular',
                                      ),
                                    ),
                                    Text(
                                      '${allergie.allergeDesc}',
                                      // medic.str5,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      allergie.discoverPlace,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',

                                      ),
                                    ),
                                    Text(
                                      '2023-12-13',
                                      // 'Start Date: ${medic.str}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: wColor,
                                        fontFamily: 'Circular',
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
                    itemCount: allergiesController.allergies.length,
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text(
                      'No Allergies Found',
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

