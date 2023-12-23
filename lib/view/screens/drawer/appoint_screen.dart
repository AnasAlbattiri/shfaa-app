import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/logic/controller/insurance_controller.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/screens/nav/calender_screen.dart';
import '../../../data/model/doctor_info_model.dart';
import '../../../logic/controller/all_appointments_controller.dart';
import '../../../logic/controller/doctor_info_controller.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../utils/local_notifications.dart';

class AppointScreen extends StatefulWidget {
  final DoctorInfoModel doctorInfoModel;

  AppointScreen({Key? key, required this.doctorInfoModel})
      : super(key: key);

  @override
  State<AppointScreen> createState() => _AppointScreenState(doctorInfoModel);
}

class _AppointScreenState extends State<AppointScreen> {
  // Variables
  int? selectedSlot;
  bool colorSelect = false;
  String? apptId;
  bool selectedSlotBool = false;
  Map<DateTime, List<String>> dateWiseTimeSlots = {};
  final DoctorInfoController docInfoController =
      Get.put(DoctorInfoController());
  AllAppointmentsController allAppointsController = AllAppointmentsController();
  DateTime _dateResourse = DateTime.now();
  DateFormat formatter = DateFormat.yMd();
  final ScrollController _scrollController = ScrollController();
  String _error = "There is no available appointments on this date.";
  String _successed = '';
  var _formKey = GlobalKey<FormState>();
  Map data = {};
  final int patientId = Get.arguments['patientId'];
  final int _siteId = Get.arguments['siteId'];
  final int _clinicId = Get.arguments['value5'];
  final int _doctorId = Get.arguments['id'];
  final DoctorInfoModel doctorInfoModel;
  int? appointId;

  _AppointScreenState(this.doctorInfoModel);
  late InsuranceController insuranceController;

  @override
  void initState() {
    super.initState();
    final int siteId = Get.arguments['siteId'];
    insuranceController = Get.put(InsuranceController(siteId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              doctorProfile(
                desc: doctorInfoModel.desc,
                empNameArb: doctorInfoModel.empNameArb!,
                str5: doctorInfoModel.str5,
                value6: doctorInfoModel.value6!,
                value: doctorInfoModel.value!,
                imageBytes: doctorInfoModel.getDocPhotoAsBytes(),
              ),
              appointmentCalendar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentCalendar() {
    return Obx(() {
      if (allAppointsController.allAppointments == null ||
          allAppointsController.isLoading.isTrue) {
        return CircularProgressIndicator();
      } else {
        var appointments = allAppointsController.allAppointments;
        List<String> timeSlots = appointments
            .where((appt) =>
                appt.resourceDate ==
                DateFormat('dd/MM/yyyy')
                    .format(allAppointsController.selectedDate))
            .map((appt) => appt.startTime)
            .toList();

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                        helpText: 'Select booking appointment date',
                        confirmText: 'Select',
                        cancelText: 'Not now',
                      );
                      if (picked != null &&
                          picked != allAppointsController.selectedDate) {
                        setState(() {
                          _dateResourse = picked;
                          // Additional logic if needed
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Text('Please select date :   ',
                            style: TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 16,
                                color: wColor)),
                        Text(
                          DateFormat('dd/MM/yyyy').format(_dateResourse),
                          style: TextStyle(
                              fontFamily: 'Circular',
                              fontSize: 16,
                              color: wColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: allAppointsController.getTimeAppResource(
                    _siteId.toString(),
                    _clinicId,
                    _doctorId,
                    formatter.format(_dateResourse)),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null && snapshot.data.length != 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Available time slots:',
                                style: TextStyle(
                                    fontFamily: 'Circular', fontSize: 20)),
                            Text(DateFormat('dd/MM/yyyy').format(_dateResourse),
                                style: TextStyle(
                                    fontFamily: 'Circular', fontSize: 20)),
                          ],
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: List.generate(snapshot.data.length, (i) {
                            return ChoiceChip(
                              disabledColor: primaryColor,
                              selectedColor: mainColor,
                              label: Text(
                                snapshot.data[i].startTime,
                                style: TextStyle(
                                    color: selectedSlot == i ? wColor : bColor),
                              ),
                              selected: selectedSlot == i,
                              onSelected: (selected) {
                                setState(() {
                                  selectedSlot = selected ? i : null;
                                  appointId = snapshot.data[i].apptId;
                                });
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        // Confirm button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: selectedSlot != null
                                ? () async {
                                    bool appointmentExists =
                                        await allAppointsController
                                            .getValidationConfAppt(
                                      patientId,
                                      _doctorId.toString(),
                                      _clinicId.toString(),
                                      _siteId.toString(),
                                    );

                                    if (appointmentExists) {
                                      Get.snackbar(
                                        'Appointment Exists',
                                        'You already have an appointment with this doctor',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    } else {
                                      // Proceed with booking the appointment
                                      var apptId = appointId.toString();
                                      await allAppointsController
                                          .confirmAppointment(
                                              _siteId.toString(),
                                              patientId,
                                              'demo1',
                                              apptId);
                                      allAppointsController
                                          .removeConfirmedAppointment(
                                              appointId!);
                                      var successSnack = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Well done!',
                                          message: 'You has been successfully booked.',
                                          contentType: ContentType.success,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(successSnack);
                                      Get.off(() => CalenderScreen(),
                                          arguments: {'patientId': patientId});
                                      LocalNotifications.showDefaultNotification(
                                        title: 'Shfaa Notification',
                                        body: 'Your health is our first priority',
                                        payload: 'This is Data',
                                      );
                                    }
                                  }
                                : null,
                            child: Text(
                              'Confirm Appointment',
                              style: TextStyle(fontFamily: 'Circular'),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Button color
                              onPrimary: Colors.white, // Text color
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Center(
                              child: Image.asset(
                            'assets/images/searchNo.png',
                            height: 150,
                                width: 200,
                          )),
                          Text('Sorry no appointments found in this day.', style: TextStyle(fontFamily: 'Circular'),)
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      }
    });
  }

  Widget doctorProfile({
    required int value,
    required int value6,
    required String empNameArb,
    required String? desc,
    required String? str5,
    required Uint8List? imageBytes,
  }) {
    ImageProvider? image = (imageBytes != null
        ? MemoryImage(imageBytes)
        : AssetImage('assets/images/doctor4.jpg')) as ImageProvider<Object>?;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.8,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image!,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.9),
                  Colors.blue.withOpacity(0),
                  Colors.blue.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: primaryColor,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            cancel: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Close'),
                            ),
                            title: 'Insurance Company',
                            titleStyle: TextStyle(
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                            content: Obx(() {
                              if (insuranceController.isLoading.isTrue) {
                                return Center(child: CircularProgressIndicator());
                              } else if (insuranceController.insurances.isNotEmpty) {
                                return Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final insurance =
                                      insuranceController.insurances[index];
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Container(
                                                    height: 55,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child: Text(
                                                          insurance.insuranceNameArb,
                                                          textAlign: TextAlign.right,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.bold,
                                                            color: wColor,
                                                            fontFamily: 'Circular',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    itemCount: insuranceController.insurances.length,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 250),
                                    child: Text(
                                      'No Insurances Found',
                                      style: TextStyle(color: bColor),
                                    ),
                                  ),
                                );
                              }
                            }),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset('assets/images/insurance.png', color: primaryColor, height: 35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Patients',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: wColor,
                              fontFamily: 'Circular',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${value}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: wColor,
                              fontFamily: 'Circular',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rating',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: wColor,
                              fontFamily: 'Circular',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${value6}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: wColor,
                              fontFamily: 'Circular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${empNameArb}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                  fontFamily: 'Circular',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.monitor_heart_rounded,
                    color: Colors.red,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    desc != null ? desc.toString() : 'Unknown',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Circular',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                str5 != null
                    ? str5.toString()
                    : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Circular',
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.red[100],
        width: double.infinity,
        padding: EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = '';
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget showAlertSucssessed() {
    if (_successed != null) {
      return Container(
        color: Colors.deepOrange[100],
        width: double.infinity,
        padding: EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _successed,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _successed = '';
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

class DateTile extends StatefulWidget {
  final DateTime date;
  final bool isSelected;

  DateTile({required this.date, required this.isSelected});

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: widget.isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.3,
            spreadRadius: 0.3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.date.day}",
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${DateFormat('E').format(widget.date)}",
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
