// class UpCommingAppointmentModel {
//   final String sitedesc;
//   final int apptNo;
//   final String apptTime;
//   final String clinicName;
//   final String confirmDateStr;
//   final String doctorName;
//
//   UpCommingAppointmentModel({
//     required this.sitedesc,
//     required this.apptNo,
//     required this.apptTime,
//     required this.clinicName,
//     required this.confirmDateStr,
//     required this.doctorName,
//   });
//
//   // Factory constructor for creating an instance from JSON data
//   factory UpCommingAppointmentModel.fromJson(Map<String, dynamic> json) {
//     return UpCommingAppointmentModel(
//       sitedesc: json['sitedesc'] as String,
//       apptNo: json['apptNo'] as int,
//       apptTime: json['apptTime'] as String,
//       clinicName: json['clinicName'] as String,
//       confirmDateStr: json['confirmDateStr'] as String,
//       doctorName: json['doctorName'] as String,
//     );
//   }
//
//   // Optional: Method to convert the instance back to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'sitedesc': sitedesc,
//       'apptNo': apptNo,
//       'apptTime': apptTime,
//       'clinicName': clinicName,
//       'confirmDateStr': confirmDateStr,
//       'doctorName': doctorName,
//     };
//   }
// }
