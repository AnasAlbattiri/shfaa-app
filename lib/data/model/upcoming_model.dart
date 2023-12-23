import 'dart:convert';
import 'dart:typed_data';

class UpcomingModel {
  final String? sitedesc;
  final int? apptNo;
  final int? id;
  final int? siteId;
  final String? apptTime;
  final String? clinicName;
  final String? desc;
  final String? confirmDateStr;
  final String? doctorName;

  UpcomingModel({
    this.sitedesc,
    this.apptNo,
    this.id,
    this.siteId,
    this.apptTime,
    this.clinicName,
    this.desc,
    this.confirmDateStr,
    this.doctorName,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      sitedesc: json['sitedesc'] ?? '',
      apptNo: json['apptNo'] ?? 0,
      id: json['id'] ?? 0,
      siteId: json['siteId'] ?? 0,
      apptTime: json['apptTime'] ?? '',
      desc: json['str'] ?? '',
      clinicName: json['clinicName'] ?? '' ,
      confirmDateStr: json['confirmDateStr'] ?? '',
      doctorName: json['doctorName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sitedesc': sitedesc,
      'apptNo': apptNo,
      'id': id,
      'siteId': siteId,
      'apptTime': apptTime,
      'desc': desc,
      'clinicName': clinicName,
      'confirmDateStr': confirmDateStr,
      'doctorName': doctorName,
    };
  }

  Uint8List? getDocPhotoUpcomingAsBytes() {
    if (desc != null && desc!.isNotEmpty) {
      return base64Decode(desc!);
    }
    return null;
  }


}
