import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../utils/constants.dart';


class ResultsPdfController extends GetxController {
  var isLoading = false.obs;
  String? localPath;


  ResultsPdfController(int orderId) {
    fetchPdfFromNetwork(orderId);
  }

  Future<void> fetchPdfFromNetwork(int orderId) async {
    try {
      isLoading(true); // Set loading to true

      final response = await http.get(
        Uri.parse('http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/LabOrderResultPdf?orderId=$orderId'),
        headers: {
          HttpHeaders.acceptCharsetHeader: "utf8",
          HttpHeaders.contentTypeHeader: 'application/pdf'
        },
      );

      final bytes = response.bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = File(dir.path+"/data.pdf");

      await file.writeAsBytes(bytes, flush: true);
      localPath = file.path;
      update();

    } catch (e) {
      Get.snackbar('Error', 'Could not load the document.');
    } finally {
      isLoading(false);
    }
  }

}

class ApiServiceProvider {

  static Future<String> loadPDF(int orderId) async {
    final String BASE_URL = "http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/LabOrderResultPdf?orderId=$orderId";

    var response = await http.get(Uri.parse(BASE_URL));

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}

