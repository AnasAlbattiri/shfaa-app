class VitalsModel {
  final String type;
  final int encounterId;
  final int errNumber;
  final String result;
  final String str;
  final String str2;
  final int breathNo; // 1
  final String createdBy;
  final int heartBeatNo; // 2
  final int id;
  final String lastUpdatedBy;
  final String lastUpdatedDate;
  final String lastUpdatedTransaction;
  final int oxeginRate; // 3
  final int pressureHigh; // 4
  final int pressureLow; // 5
  final String readingDate; // 6
  final String readingTime; // 7
  final String siteDesc; // 8
  final int staffId;
  final double temperature; // 9
  final int temperatureType;
  final String vitalSignDate;

  VitalsModel({
    required this.type,
    required this.encounterId,
    required this.errNumber,
    required this.result,
    required this.str,
    required this.str2,
    required this.breathNo,
    required this.createdBy,
    required this.heartBeatNo,
    required this.id,
    required this.lastUpdatedBy,
    required this.lastUpdatedDate,
    required this.lastUpdatedTransaction,
    required this.oxeginRate,
    required this.pressureHigh,
    required this.pressureLow,
    required this.readingDate,
    required this.readingTime,
    required this.siteDesc,
    required this.staffId,
    required this.temperature,
    required this.temperatureType,
    required this.vitalSignDate,
  });

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
      type: json['type'] ?? '',
      encounterId: json['encounterId'],
      errNumber: json['errNumber'],
      result: json['result'] ?? '',
      str: json['str'] ?? '',
      str2: json['str2'] ?? '',
      breathNo: json['breathNo'],
      createdBy: json['createdBy'] ?? '',
      heartBeatNo: json['heartBeatNo'],
      id: json['id'],
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdatedDate: json['lastUpdatedDate'] ?? '',
      lastUpdatedTransaction: json['lastUpdatedTransaction'] ?? '',
      oxeginRate: json['oxeginRate'],
      pressureHigh: json['pressureHigh'],
      pressureLow: json['pressureLow'],
      readingDate: json['readingDate'] ?? '',
      readingTime: json['readingTime'] ?? '',
      siteDesc: json['siteDesc'] ?? '',
      staffId: json['staffId'],
      temperature: json['temperature'].toDouble(),
      temperatureType: json['temperatureType'],
      vitalSignDate: json['vitalSignDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'encounterId': encounterId,
      'errNumber': errNumber,
      'result': result,
      'str': str,
      'str2': str2,
      'breathNo': breathNo,
      'createdBy': createdBy,
      'heartBeatNo': heartBeatNo,
      'id': id,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdatedDate': lastUpdatedDate,
      'lastUpdatedTransaction': lastUpdatedTransaction,
      'oxeginRate': oxeginRate,
      'pressureHigh': pressureHigh,
      'pressureLow': pressureLow,
      'readingDate': readingDate,
      'readingTime': readingTime,
      'siteDesc': siteDesc,
      'staffId': staffId,
      'temperature': temperature,
      'temperatureType': temperatureType,
      'vitalSignDate': vitalSignDate,
    };
  }
}
