import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/rad_results_model.dart';
import 'package:patient_app/data/model/radiation_model.dart';
import 'package:patient_app/logic/controller/rad/rad_results_controller.dart';
import '../../../logic/controller/main/auth_controller.dart';
import '../../../logic/controller/rad/radiation_controller.dart';
import '../../../utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../widgets/print/pw_all_fields.dart';


class RadResultsScreen extends StatefulWidget {
  const RadResultsScreen({
    super.key,
  });

  @override
  State<RadResultsScreen> createState() => _RadResultsScreenState();
}

class _RadResultsScreenState extends State<RadResultsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  late RadResultsController radResultsController;
  late RadiationController radiationController;

  @override
  void initState() {
    super.initState();
    radResultsController = Get.put(RadResultsController(10617, 1));
    radiationController = Get.put(RadiationController(9577, 2));
  }

  Future<void> printDoc() async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pwBuildPdfContent();
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Radiology Result', style: TextStyle(fontFamily: 'Circular'),),
        centerTitle: true,
      ),
      backgroundColor: wColor,
      body: Obx(() {
        if (radResultsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (radResultsController.radResults.isNotEmpty) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          allFields(radResultsController.radResults.first,
                              radiationController.rays.first),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () => printDoc(),
                              child: const Text(
                                "Save as PDF",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Circular'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
              child: Text("No Radiology Result available"));
        }
      }),
    );
  }

  Widget TextFieldWidget(
      String title, String hintText,
      {Function? onTap,
        bool readOnly = true,
        bool isMultiline = false,
        ScrollController? scrollController}) {
    int? maxLines =
    isMultiline ? 20 : 1; // Allow multiline input if isMultiline is true

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
        SizedBox(
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
            style: TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.bold,
            ),
            minLines: 1,
            maxLines: 9999, // This will allow the field to expand
            keyboardType:
            isMultiline ? TextInputType.multiline : TextInputType.text,
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
            SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              'Test Name',
              '${radiationModel.testDesc}',
              onTap: () async {},
              readOnly: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget('Test Date', '${radResults.str}', onTap: () async {}, readOnly: true),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget('Test Time', '${radResults.str2}',
                onTap: () async {}, readOnly: true),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget(
                'Test Result', '${radResults.bodyText}',
                isMultiline: true, scrollController: scrollController),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget pwBuildPdfContent() {
    return pw.Container(
      child: pwAllFields(
        radResultsController.radResults.first,
        radiationController.rays.first,
      ),
    );
  }

}
