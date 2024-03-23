import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import '../../../logic/controller/lab/lab_results_pdf_controller.dart';
import '../../../utils/constants.dart';
import 'package:share_plus/share_plus.dart';

class OtherResultScreen extends StatefulWidget {
  const OtherResultScreen({super.key});

  @override
  State<OtherResultScreen> createState() => _OtherResultScreenState();
}

class _OtherResultScreenState extends State<OtherResultScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    final int orderId = Get.arguments['orderId'];

    ApiServiceProvider.loadPDF(orderId).then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (localPath != null)
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                Share.shareFiles([localPath!], text: 'Download your PDF file');
              },
            ),
        ],
        backgroundColor: primaryColor,
        title: const Text(
          'Laboratory Results',
          style: TextStyle(
            fontFamily: 'Circular',
            color: wColor,
            fontSize: 24,
          ),
        ),
      ),
      body: localPath != null
          ? Center(
            child: Container(
              height: 600,
              width: double.infinity,
              child: PDFView(
                filePath: localPath,
              ),
            ),
          )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
