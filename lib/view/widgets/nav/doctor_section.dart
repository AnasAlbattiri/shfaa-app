import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/doctor_info_model.dart';
import 'package:patient_app/logic/controller/doctor_info_controller.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/screens/drawer/appoint_screen.dart';

class DoctorsSection extends StatelessWidget {
  DoctorsSection({Key? key}) : super(key: key);

  final DoctorInfoController docInfoController = Get.put(DoctorInfoController());
  final int patientId = Get.arguments['patientId'];



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var displayList = docInfoController.searchController.text.isNotEmpty
          ? docInfoController.searchList
          : docInfoController.docInfo;

      if (docInfoController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (displayList.isNotEmpty) {
        return buildDoctorGrid(displayList);
      } else {
        return Center(child: Text("No doctor information available", style: TextStyle(fontFamily: 'Circular'),));
      }
    });
  }

  Widget buildDoctorGrid(List<DoctorInfoModel> doctors) {
    return Container(
      height: 400,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.67,
          mainAxisSpacing: 9.0,
          crossAxisSpacing: 6.0,
        ),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return buildDoctorCard(doctors[index], index);
        },
      ),
    );
  }


  Widget buildDoctorCard(DoctorInfoModel docInfo, int index) {
    Uint8List? imageBytes = docInfo.getDocPhotoAsBytes();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: InkWell(
                  onTap: (){
                    if(docInfoController.searchController.text.isNotEmpty){
                      Get.to(() => AppointScreen(doctorInfoModel: docInfoController.searchList[index]), arguments: {
                        'id': docInfo.id,
                        'value5': docInfo.value5,
                        'patientId': patientId,
                        'siteId': docInfo.siteId,
                        'index': docInfo,
                      });
                    } else {
                      Get.to(() => AppointScreen(doctorInfoModel: docInfoController.docInfo[index]), arguments: {
                        'id': docInfo.id,
                        'value5': docInfo.value5,
                        'patientId': patientId,
                        'siteId': docInfo.siteId,
                        'index': docInfo,
                      });
                    }
                  },
                  child: imageBytes != null ? Image.memory(imageBytes,fit: BoxFit.cover,height: 200, width: 200,) : Image.asset('assets/images/doctor4.jpg', fit: BoxFit.cover,height: 200, width: 200,),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${docInfo.empNameArb}',
                        maxLines: 2,
                        style: TextStyle(
                          // TODO: API
                          fontSize: 16,
                          fontFamily: 'Circular',
                        ),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        docInfo.desc!,
                        maxLines: 2,
                        style: TextStyle(
                          // TODO: API
                          fontSize: 14,
                          fontFamily: 'Circular',
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 5,),

                      Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text('Rating', style: TextStyle(fontFamily: 'Circular', fontSize: 10, color: wColor),)),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${docInfo.value6}',
                      style: TextStyle(
                        // TODO: API
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Circular',
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
