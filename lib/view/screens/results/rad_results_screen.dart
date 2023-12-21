import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/rad_results_model.dart';
import 'package:patient_app/data/model/radiation_model.dart';
import 'package:patient_app/logic/controller/rad_results_controller.dart';
import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/radiation_controller.dart';
import '../../../utils/constants.dart';

class RadResultsScreen extends StatefulWidget {
  const RadResultsScreen({super.key,});



  @override
  State<RadResultsScreen> createState() => _RadResultsScreenState();
}

class _RadResultsScreenState extends State<RadResultsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sexAgeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  late RadResultsController radResultsController;
  late RadiationController radiationController;

  @override
  void initState() {
    super.initState();
    radResultsController = Get.put(RadResultsController(10617, 1));
    radiationController = Get.put(RadiationController(9577));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Radiology Result'),
        centerTitle: true,
      ),
      backgroundColor: wColor,
      body: Obx(() {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  children: [
                    allFields(radResultsController.radResults.first, radiationController.rays.first ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget TextFieldWidget(String title, String hintText,
      TextEditingController controller,
      {Function? onTap, bool readOnly = true, bool isMultiline = false, ScrollController? scrollController}) {
    int? maxLines = isMultiline ? 20 : 1; // Allow multiline input if isMultiline is true

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
            onTap: () => onTap?.call(),
            controller: controller,
            style: TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.bold,
            ),
            minLines: 1,
            maxLines: 9999, // This will allow the field to expand
            keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
            scrollPadding: EdgeInsets.all(20.0),

            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'Circular',
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


  Widget allFields(RadResultsModel radResults, RadiationModel radiationModel) {
    ScrollController scrollController = ScrollController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFieldWidget(
                'Test Name',
                '${radiationModel.testDesc}',
                sexAgeController, onTap: () async {}, readOnly: true, ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget('Test Date', '${radResults.str}',
                phoneController, onTap: () async {}, readOnly: true),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                'Test Time',
                '${radResults.str2}',
                sexAgeController, onTap: () async {}, readOnly: true),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget('Test Result', '${radResults.bodyText}', nameController, isMultiline: true, scrollController: scrollController),

          ],
        ),
      ),
    );
  }
}
