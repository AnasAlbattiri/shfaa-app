import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/logic/controller/all_appointments_controller.dart';
import 'package:patient_app/logic/controller/upcoming_controller.dart';
import 'package:patient_app/utils/constants.dart';

import '../../../data/model/upcoming_model.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard({
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  late UpcomingController upcomingController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    upcomingController = Get.put(UpcomingController(patientId));
  }

  // TODO: API
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(upcomingController.isLoading.isTrue) {
        return Center(child: CircularProgressIndicator(),);
      } else if (upcomingController.upcomings.isNotEmpty){
        return upcomingList(upcomingController: upcomingController);
      } else {
        return Center(child: Text('No Upcoming Found', style: TextStyle(color: bColor, fontFamily: 'Circular',),),);
      }
    });
  }
}

class upcomingList extends StatelessWidget {
  upcomingList({
    super.key,
    required this.upcomingController,
  });

  final UpcomingController upcomingController;
  final AllAppointmentsController allAppointmentsController = Get.put((AllAppointmentsController()));


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final upcoming = upcomingController.upcomings[index];

          return buildUpcomingCard(upcoming, index);
        },
        itemCount: upcomingController.upcomings.length,
      ),
    );
  }

  buildUpcomingCard(UpcomingModel upcomingModel, int index){
    Uint8List? imageBytes = upcomingModel.getDocPhotoUpcomingAsBytes();
    final upcoming = upcomingController.upcomings[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: double.maxFinite,
        height: 180,
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
              child: imageBytes != null ?
              Image.memory(imageBytes, width: 50, height: 50, fit: BoxFit.cover) :
              Image.asset('assets/images/doctor4.jpg', width: 50, height: 50, fit: BoxFit.cover), // Default image if `imageBytes` is null
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  upcoming.doctorName!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: wColor,
                    fontFamily: 'Circular',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  upcoming.clinicName!,
                  style: TextStyle(
                    color: wColor,
                    fontFamily: 'Circular',
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
                          '${upcoming.confirmDateStr}',
                          style: TextStyle(color: Colors.white, fontFamily: 'Circular',),
                        ),
                      ),

                      Text(
                        '${upcoming.apptTime}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Circular',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Builder(
                      builder: (context){
                        return SizedBox(
                          height: 34,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              final int patientId = Get.arguments['patientId'];
                              allAppointmentsController.cancelAppointment(upcoming.apptNo!, upcoming.siteId!, patientId);
                              upcomingController.removeAppointment(upcoming.apptNo!);
                              var successSnack = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Well done!',
                                  message: 'You has been successfully cancelled.',
                                  contentType: ContentType.success,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(successSnack);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: wColor,
                                fontFamily: 'Circular',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // SizedBox(
                    //   height: 34,
                    //   child: OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //       backgroundColor: Colors.green,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //     ),
                    //     onPressed: () {},
                    //     child: const Text(
                    //       'Completed',
                    //       style: TextStyle(
                    //         color: wColor,
                    //         fontFamily: 'Circular',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
