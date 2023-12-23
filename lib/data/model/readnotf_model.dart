class ReadNotfModel {
  final String type;
  final String str;
  final String str2;
  final String str3;
  final String desc;
  final int encounterId;
  final int errNumber;
  final int value;
  final int value2;
  final int criticalResult;
  final int id;
  final DateTime lastUpdateDate;
  final String notificationDescriptionArb;
  final int notificationId;
  final int notificationStatus;
  final int orderCategory;
  final int patientId;
  final int servId;

  ReadNotfModel({
    required this.type,
    required this.str,
    required this.str2,
    required this.str3,
    required this.desc,
    required this.encounterId,
    required this.errNumber,
    required this.value,
    required this.value2,
    required this.criticalResult,
    required this.id,
    required this.lastUpdateDate,
    required this.notificationDescriptionArb,
    required this.notificationId,
    required this.notificationStatus,
    required this.orderCategory,
    required this.patientId,
    required this.servId,
  });

  factory ReadNotfModel.fromJson(Map<String, dynamic> json) {
    return ReadNotfModel(
      type: json['type'],
      str: json['str'] ?? '',
      str2: json['str2'] ?? '',
      str3: json['str3'] ?? '',
      desc: json['desc'] ?? '',
      encounterId: json['encounterId'],
      errNumber: json['errNumber'],
      value: json['value'],
      value2: json['value2'],
      criticalResult: json['criticalResult'],
      id: json['id'],
      lastUpdateDate: DateTime.parse(json['lastUpdateDate']),
      notificationDescriptionArb: json['notificationDescriptionArb'] ?? '',
      notificationId: json['notificationId'],
      notificationStatus: json['notificationStatus'],
      orderCategory: json['orderCategory'],
      patientId: json['patientId'],
      servId: json['servId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'str': str,
      'str2': str2,
      'str3': str3,
      'desc': desc,
      'encounterId': encounterId,
      'errNumber': errNumber,
      'value': value,
      'value2': value2,
      'criticalResult': criticalResult,
      'id': id,
      'lastUpdateDate': lastUpdateDate.toIso8601String(),
      'notificationDescriptionArb': notificationDescriptionArb,
      'notificationId': notificationId,
      'notificationStatus': notificationStatus,
      'orderCategory': orderCategory,
      'patientId': patientId,
      'servId': servId,
    };
  }
}
