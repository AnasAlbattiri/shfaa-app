import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/notif/readnotf_controller.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  late ReadNotfController readNotfController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    readNotfController = Get.put(ReadNotfController(patientId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
        'Notifications',
        style: TextStyle(
          fontFamily: 'Circular',
          color: wColor,
          fontSize: 20,
        ),
      ),
      ),
      body: Obx(() {
        if (readNotfController.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else if (readNotfController.readNotifs.isNotEmpty) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return notificationItem(index);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 0,
              );
            },
            itemCount: readNotfController.readNotifs.length,
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Text(
                'No Notifications Found',
                style: TextStyle(color: bColor),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget notificationItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  timeAndDate(index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: Icon(
        Icons.notifications,
        size: 25,
        color: mainColor,
      ),
    );
  }

  Widget message(int index) {
    final readNotf = readNotfController.readNotifs[index];

    double textSize = 14;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: readNotf.desc,
                style: TextStyle(
                  fontSize: textSize,
                  color: bColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Circular',

                ),
             ),
          ),
          Text(
              readNotf.notificationDescriptionArb,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Circular',

              ),),
          Text(
            readNotf.str3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Circular',
              fontSize: 14,

            ),),

        ],
      ),
    );
  }

  Widget timeAndDate(int index) {
    final readNotf = readNotfController.readNotifs[index];

    return Container(
      margin: EdgeInsets.only(
        top: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            readNotf.str,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            readNotf.str2,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
