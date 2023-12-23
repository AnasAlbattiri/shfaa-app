class AllergiesModel {
  final String type;
  final int errNumber;
  final String result;
  final String allergeDesc; // 1
  final int allergyValue;
  final String createdBy;
  final String creationDate;
  final String discoverPlace; // 2
  final String discoverStartDate; // 3
  final int id;
  final String lastUpdatedBy;
  final String lastUpdatedDate;
  final String lastUpdatedTransaction;
  final int patientId;
  final int siteId;

  AllergiesModel({
    required this.type,
    required this.errNumber,
    required this.result,
    required this.allergeDesc,
    required this.allergyValue,
    required this.createdBy,
    required this.creationDate,
    required this.discoverPlace,
    required this.discoverStartDate,
    required this.id,
    required this.lastUpdatedBy,
    required this.lastUpdatedDate,
    required this.lastUpdatedTransaction,
    required this.patientId,
    required this.siteId,
  });

  factory AllergiesModel.fromJson(Map<String, dynamic> json) {
    return AllergiesModel(
      type: json['type'] ?? '',
      errNumber: json['errNumber'],
      result: json['result'] ?? '',
      allergeDesc: json['allergeDesc'] ?? '',
      allergyValue: json['allergyValue'],
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      discoverPlace: json['discoverPlace'] ?? '',
      discoverStartDate: json['discoverStartDate'] ?? '',
      id: json['id'],
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdatedDate: json['lastUpdatedDate'] ?? '',
      lastUpdatedTransaction: json['lastUpdatedTransaction'] ?? '',
      patientId: json['patientId'],
      siteId: json['siteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'errNumber': errNumber,
      'result': result,
      'allergeDesc': allergeDesc,
      'allergyValue': allergyValue,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'discoverPlace': discoverPlace,
      'discoverStartDate': discoverStartDate,
      'id': id,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdatedDate': lastUpdatedDate,
      'lastUpdatedTransaction': lastUpdatedTransaction,
      'patientId': patientId,
      'siteId': siteId,
    };
  }
}
