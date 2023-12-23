class VisitsModel {
  final String type;
  final int errNumber;
  final String creationDate;
  final String doctorName; // 6
  final String encounterDate;
  final String encounterDateFormat; // 5
  final int encounterNo;
  final String encounterStatusDescEng; // 2
  final String encounterTypeDescEng; // 4
  final int id;
  final String lastUpdatedBy;
  final String locationDescEng; // 1
  final String siteDescEng; // 3
  final int siteId;

  VisitsModel({
    required this.type,
    required this.errNumber,
    required this.creationDate,
    required this.doctorName,
    required this.encounterDate,
    required this.encounterDateFormat,
    required this.encounterNo,
    required this.encounterStatusDescEng,
    required this.encounterTypeDescEng,
    required this.id,
    required this.lastUpdatedBy,
    required this.locationDescEng,
    required this.siteDescEng,
    required this.siteId,
  });

  factory VisitsModel.fromJson(Map<String, dynamic> json) {
    return VisitsModel(
      type: json['type'] ?? '',
      errNumber: json['errNumber'] ?? 0,
      creationDate: json['creationDate'] ?? '',
      doctorName: json['doctorName'] ?? '',
      encounterDate: json['encounterDate'] ?? '',
      encounterDateFormat: json['encounterDateFormat'] ?? '',
      encounterNo: json['encounterNo'] ?? 0,
      encounterStatusDescEng: json['encounterStatusDescEng'] ?? '',
      encounterTypeDescEng: json['encounterTypeDescEng'] ?? '',
      id: json['id'] ?? 0,
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      locationDescEng: json['locationDescEng'] ?? '',
      siteDescEng: json['siteDescEng'] ?? '',
      siteId: json['siteId'] ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'errNumber': errNumber,
      'creationDate': creationDate,
      'doctorName': doctorName,
      'encounterDate': encounterDate,
      'encounterDateFormat': encounterDateFormat,
      'encounterNo': encounterNo,
      'encounterStatusDescEng': encounterStatusDescEng,
      'encounterTypeDescEng': encounterTypeDescEng,
      'id': id,
      'lastUpdatedBy': lastUpdatedBy,
      'locationDescEng': locationDescEng,
      'siteDescEng': siteDescEng,
      'siteId': siteId,
    };
  }
}
