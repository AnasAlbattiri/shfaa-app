import 'dart:typed_data';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/patient_info_model.dart';
import 'package:patient_app/logic/controller/patient_info_controller.dart';
import 'package:patient_app/logic/controller/unreadnotf_controller.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/doctor_info_controller.dart';
import '../../../logic/controller/update_notf_controller.dart';
import '../../widgets/nav/doctor_section.dart';
import '../drawer/all_labs_screen.dart';
import '../drawer/all_rays_screen.dart';
import '../drawer/allergies_screen.dart';
import '../drawer/notifications_screen.dart';
import '../drawer/vitals_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'calender_screen.dart';
import 'medic_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PatientInfoController patInfoController;
  late DoctorInfoController doctorInfoController;

  late UnReadNotfController unReadNotfController;

  final int patientId = Get.arguments['patientId'];

  final UpdateNotfController updateNotfController = Get.put(UpdateNotfController());

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    doctorInfoController = Get.put(DoctorInfoController());
    doctorInfoController.fetchDoctorInfo();
    patInfoController = Get.put(PatientInfoController(patientId));
    unReadNotfController = Get.put(UnReadNotfController(patientId));
  }
  final List<String> categories = ['Active','Pending'];
  List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    Colors.blueAccent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (patInfoController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (patInfoController.patInfo.isNotEmpty) {
                      return patientInfo(patInfoController.patInfo.first);
                    } else {
                      return Center(
                          child: Text("No patient information available"));
                    }
                  }),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'Book your appointments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: bColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DoctorsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(

        backgroundColor: wColor,
        width: 250,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,

                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(50)),
                  ),
                ),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: patientPicture(patInfoController.patInfo.first),
                  );
                }),

              ],
            ),
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.view_timeline_outlined,
                        size: 26,
                        color: wColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Vitals',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => VitalsScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 26,
                        color: wColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Allergies',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => AllergiesScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.archive,
                        size: 26,
                        color: wColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Visits history',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];
                    Get.to(() => CalenderScreen(),
                        arguments: {'patientId': patientId});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 26,
                        color: wColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Notifications',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => NotificationsScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/images/lab.png', height: 30, width: 26,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Laboratoires',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => AllLabsScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/images/radiology.png', height: 30, width: 26,),

                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Radiology',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => AllRaysScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/images/medic.png', height: 35, width: 28,),

                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Medications',
                        style: TextStyle(fontSize: 18, color: wColor, fontFamily: 'Circular'),
                      ),
                    ],
                  ),
                  onTap: () {
                    final int patientId = Get.arguments['patientId'];

                    Get.to(() => MedicScreen(), arguments: {
                      'patientId': patientId,
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget patientPicture(PatientInfoModel patInfo){
    Uint8List? imageBytes = patInfo.getPhotoAsBytes();
    return CircleAvatar(
      radius: 45,
      backgroundImage: MemoryImage(imageBytes!),
    );
  }
  Widget patientInfo(PatientInfoModel patInfo) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  return IconButton(onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }, icon: Icon(Icons.menu, color: wColor, size: 35,));
                }
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Close'),
                    ),
                    title: 'Notifications',
                    titleStyle: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                    content: Obx(() {
                      if (unReadNotfController.isLoading.isTrue) {
                        return Center(child: CircularProgressIndicator());
                      } else if (unReadNotfController.unNotifs.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final unNotif = unReadNotfController.unNotifs[index];

                              return InkWell(child: notificationItem(index), onTap: (){
                                int patId = unNotif.patientId;
                                int sysNotiId = unNotif.id;
                                updateNotfController.updateNotification(sysNotiId, patId);
                                unReadNotfController.removeClickedNotification(sysNotiId);
                                print(patId);
                                Get.to(() => NotificationsScreen(),arguments: {
                                  'patientId': unNotif.patientId,
                                } );
                                // print(patientId);

                              },);
                            },
                            itemCount: unReadNotfController.unNotifs.length,
                          ),
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
                },
                icon: badges.Badge(
                  badgeContent: Text('${unReadNotfController.unNotifs.length}', style: TextStyle(fontFamily: 'Circular', color: wColor, fontSize: 13),),
                  badgeAnimation: BadgeAnimation.slide(),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: wColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Hi, ${patInfo.firstNameE} ${patInfo.lastNameE}',
            style: TextStyle(
              color: wColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your health matters most',
            style: TextStyle(
              color: wColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          GetBuilder<DoctorInfoController>(builder: (_) {
            return Container(
              margin: EdgeInsets.only(
                top: 15,
                bottom: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: wColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: TextFormField(
                controller: doctorInfoController.searchController,
                onChanged: (searchName) {
                  doctorInfoController.addSearchToList(searchName);
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      doctorInfoController.clearSearch();
                    },
                    icon: doctorInfoController.searchController.text.isNotEmpty
                        ? Icon(
                            Icons.close,
                            color: bColor,
                          )
                        : Container(),
                  ),
                  border: InputBorder.none,
                  hintText: 'Search here...',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
  Widget notificationItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 6,
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
      height: 45,
      width: 45,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: Icon(
        Icons.notifications,
        size: 20,
        color: mainColor,
      ),
    );
  }

  Widget message(int index) {
    final unNotif = unReadNotfController.unNotifs[index];

    double textSize = 14;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.ltr,
            text: TextSpan(
              text: unNotif.desc,
              style: TextStyle(
                fontSize: textSize,
                color: bColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
              ),
            ),
          ),
          Text(
            unNotif.notificationDescriptionArb,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),),
          Text(
            unNotif.str3,
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
    final unNotif = unReadNotfController.unNotifs[index];


    return Container(
      margin: EdgeInsets.only(
        top: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            unNotif.str,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            unNotif.str2,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
