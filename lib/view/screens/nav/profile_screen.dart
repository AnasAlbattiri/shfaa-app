import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/patient_info_model.dart';
import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/patient_info_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../widgets/profile/green_intro_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sexAgeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  late PatientInfoController patInfoController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    patInfoController = Get.put(PatientInfoController(patientId));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      body: Obx(() {
        if (patInfoController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (patInfoController.patInfo.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.25,
                  child: Stack(
                    children: [
                      greenIntroWidgetWithoutLogos(),
                      profilePhoto(patInfoController.patInfo.first),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                allFields(patInfoController.patInfo.first),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        authController.signOut();
                        // Navigate back to the login screen
                        Get.offAllNamed(AppRoutes.login);

                      },
                      child: Text(
                        "Signout",
                        style: TextStyle(fontFamily: 'Circular'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
              child: Text("No patient information available"));
        }
      }),
    );
  }

  TextFieldWidget(String title, String hintText, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Circular',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: () => onTap!(),
            validator: (input) => validator(input),
            controller: controller,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: primaryColor,
                ),
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              hintText: hintText,
            ),
          ),
        )
      ],
    );
  }

  Widget allFields(PatientInfoModel patInfo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFieldWidget('Name', '${patInfo.fullNameEng}',
                Icons.person_outlined, nameController, (String? input) {
              if (input!.isEmpty) {
                return 'Name is required!';
              }
              if (input.length < 5) {
                return 'Please enter a valid name!';
              }
              return null;
            }),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget('Phone Number', '${patInfo.mobileno}', Icons.phone,
                phoneController, (String? input) {
              if (input!.isEmpty) {
                return 'Phone Number is required!';
              }
              return null;
            }, onTap: () async {}, readOnly: true),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                'Sex and Age',
                '${patInfo.str5}',
                Icons.calendar_today_outlined,
                sexAgeController, (String? input) {
              if (input!.isEmpty) {
                return 'Sex and Age is required!';
              }

              return null;
            }, onTap: () async {}, readOnly: true),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                'Date of birth',
                '${patInfo.dateOfBirth}',
                Icons.cake,
                sexAgeController, (String? input) {
              if (input!.isEmpty) {
                return 'Date of birth is required!';
              }

              return null;
            }, onTap: () async {}, readOnly: true),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }

  Widget profilePhoto(PatientInfoModel patInfo) {
    Uint8List? imageBytes = patInfo.getPhotoAsBytes();
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 120,
          height: 120,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(
                  imageBytes!,
                ),
              ),
              shape: BoxShape.circle,
              color: Color(0xffD6D6D6)),
        ),
      ),
    );
  }
}
