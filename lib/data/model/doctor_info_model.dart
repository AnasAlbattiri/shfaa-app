import 'dart:convert';
import 'dart:typed_data';

class DoctorInfoModel {
  final String? type;
  final String? desc;
  final String? counter;
  final String? str5;
  final int? errNumber;
  final int? value; // Patients
  final int? value5; // clinicId
  final int? value6;
  final String? empNameArb;
  final int? id; // doctorId
  final int? siteId;

  DoctorInfoModel({
    this.type,
    this.desc,
    this.counter,
    this.str5,
    this.errNumber,
    this.value,
    this.value5,
    this.value6,
    this.empNameArb,
    this.id,
    this.siteId,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      str5: json['str5'] ?? '',
      counter: json['counter'] ?? '',
      errNumber: json['errNumber'],
      value: json['value'] ?? 0,
      value5: json['value5'] ?? 0,
      value6: json['value6'] ?? 0,
      empNameArb: json['empNameArb'] ?? '',
      id: json['id'] ?? 0,
      siteId: json['siteId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'desc': desc,
      'counter': counter,
      'str5': str5,
      'errNumber': errNumber,
      'value': value,
      'value5': value5,
      'value6': value6,
      'empNameArb': empNameArb,
      'id': id,
      'siteId': siteId,
    };
  }

  Uint8List? getDocPhotoAsBytes() {
    if (counter != null && counter!.isNotEmpty) {
      return base64Decode(counter!);
    }
    return null;
  }
}
