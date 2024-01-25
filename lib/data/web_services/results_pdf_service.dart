// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import '../../utils/constants.dart';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class AllergiesService {
//   Future<void> loadPdfFromNetwork() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/LabOrderResultPdf?orderId=20523'), // Replace with your API endpoint
//         headers: {
//           HttpHeaders.acceptCharsetHeader: "utf8",
//           HttpHeaders.contentTypeHeader: 'application/pdf'
//
//         },
//       );
//
//       final bytes = response.bodyBytes;
//       final dir = await getTemporaryDirectory();
//       final file = File('${dir.path}/report.pdf');
//
//       await file.writeAsBytes(bytes, flush: true);
//       if (mounted) {
//         setState(() {
//           localPath = file.path;
//         });
//       }
//     } catch (e) {
//       // Handle errors
//       Get.snackbar('Error', 'Could not load the document.');
//     }
//   }
// }
