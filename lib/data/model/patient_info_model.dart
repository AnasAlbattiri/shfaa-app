import 'dart:convert';
import 'dart:typed_data';

class PatientInfoModel {
  final String? type;
  final String? counter;
  final String? desc;
  final int? errNumber;
  final String? str5;
  final int? value;
  final String? createdBy;
  final String? creationDate;
  final String? dateOfBirth;
  final String? fatherNameA;
  final String? fatherNameE;
  final String? firstNameA;
  final String? firstNameE;
  final String? fullNameArb;
  final String? fullNameEng;
  final String? grandfatherNameA;
  final String? grandfatherNameE;
  final int? id;
  final String? lastNameA;
  final String? lastNameE;
  final String? lastUpdatedBy;
  final String? lastUpdatedDate;
  final String? lastUpdatedTransaction;
  final String? mobileno;
  final String? patientNo;
  final String? patientPhoto;
  final int? sex;
  final int? siteId;

  PatientInfoModel({
    this.type,

    this.counter,

    this.desc,

    this.errNumber,

    this.str5,

    this.value,

    this.createdBy,

    this.creationDate,

    this.dateOfBirth,

    this.fatherNameA,

    this.fatherNameE,

    this.firstNameA,

    this.firstNameE,

    this.fullNameArb,

    this.fullNameEng,

    this.grandfatherNameA,

    this.grandfatherNameE,

    this.id,

    this.lastNameA,

    this.lastNameE,

    this.lastUpdatedBy,

    this.lastUpdatedDate,

    this.lastUpdatedTransaction,

    this.mobileno,

    this.patientNo,

    this.patientPhoto,

    this.sex,

    this.siteId,
  });

  factory PatientInfoModel.fromJson(Map<String, dynamic> json) {
    return PatientInfoModel(
      type: json['type'] ?? '',
      counter: json['counter'] ?? '',
      desc: json['desc'] ?? '',
      errNumber: json['errNumber'],
      str5: json['str5'] ?? '',
      value: json['value'],
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      dateOfBirth: json['str'] ?? '', // Date of birth edited
      fatherNameA: json['fatherNameA'] ?? '',
      fatherNameE: json['fatherNameE'] ?? '',
      firstNameA: json['firstNameA'] ?? '',
      firstNameE: json['firstNameE'] ?? '',
      fullNameArb: json['fullNameArb'] ?? '',
      fullNameEng: json['fullNameEng'] ?? '',
      grandfatherNameA: json['grandfatherNameA'] ?? '',
      grandfatherNameE: json['grandfatherNameE'] ?? '',
      id: json['id'],
      lastNameA: json['lastNameA'] ?? '',
      lastNameE: json['lastNameE'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdatedDate: json['lastUpdatedDate'] ?? '',
      lastUpdatedTransaction: json['lastUpdatedTransaction'] ?? '',
      mobileno: json['mobileno'] ?? '',
      patientNo: json['patientNo'] ?? '',
      patientPhoto: json['patientPhoto'] ?? '',
      sex: json['sex'],
      siteId: json['siteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'counter': counter,
      'desc': desc,
      'errNumber': errNumber,
      'str5': str5,
      'value': value,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'dateOfBirth': dateOfBirth,
      'fatherNameA': fatherNameA,
      'fatherNameE': fatherNameE,
      'firstNameA': firstNameA,
      'firstNameE': firstNameE,
      'fullNameArb': fullNameArb,
      'fullNameEng': fullNameEng,
      'grandfatherNameA': grandfatherNameA,
      'grandfatherNameE': grandfatherNameE,
      'id': id,
      'lastNameA': lastNameA,
      'lastNameE': lastNameE,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdatedDate': lastUpdatedDate,
      'lastUpdatedTransaction': lastUpdatedTransaction,
      'mobileno': mobileno,
      'patientNo': patientNo,
      'patientPhoto': patientPhoto,
      'sex': sex,
      'siteId': siteId,
    };
  }

  Uint8List? getPhotoAsBytes() {
    if (this.counter != null && this.counter!.isNotEmpty) {
      return base64Decode(this.counter!);
    }
    return null;
  }

}
