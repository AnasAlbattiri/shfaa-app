import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/logic/controller/auth_controller.dart';
import '../../../logic/controller/main_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../utils/constants.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   final int patientId = 153259;
  //
  //
  //
  // }
  final mainController = Get.put(MainController());

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            buttonBackgroundColor: primaryColor.withOpacity(0.95),
            backgroundColor: mainColor,
            color: Colors.white,
            items: [
              Icon(
                Icons.home,
                color: mainController.currentIndex == 0 ? Colors.white : bColor,
              ),
              Icon(
                Icons.calendar_month,
                color: mainController.currentIndex == 1 ?Colors.white : bColor,
              ),
              Icon(
                Icons.price_change_rounded,
                color: mainController.currentIndex == 2 ? Colors.white : bColor,
              ),
              Icon(
                Icons.medical_services_rounded,
                color: mainController.currentIndex == 3 ? Colors.white : bColor,
              ),
              Icon(
                Icons.person,
                color: mainController.currentIndex == 4 ? Colors.white : bColor,
              ),
            ],
            index: mainController.currentIndex.value,
            onTap: (index) {
              mainController.currentIndex.value = index;
            },
          ),
          body: IndexedStack(
            index: mainController.currentIndex.value,
            children: mainController.screens,
          ),
        ),
      );
    });
  }
}