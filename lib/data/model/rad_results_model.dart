class RadResultsModel {
  final String type;
  final bool boolean1;
  final int errNumber;
  final String str;
  final String str2;
  final int value;
  final int value3;
  final int auditFlag;
  final String bodyText;
  final String createdBy;
  final DateTime creationDate;
  final int id;
  final String lastUpdatedBy;
  final DateTime lastUpdatedDate;
  final String lastUpdatedTransaction;
  final int radOrdDtlId;
  final String resultEnteredBy;
  final DateTime resultEnteredDate;
  final DateTime resultEnteredTime;
  final int siteId;

  RadResultsModel({
    required this.type,
    required this.boolean1,
    required this.errNumber,
    required this.str,
    required this.str2,
    required this.value,
    required this.value3,
    required this.auditFlag,
    required this.bodyText,
    required this.createdBy,
    required this.creationDate,
    required this.id,
    required this.lastUpdatedBy,
    required this.lastUpdatedDate,
    required this.lastUpdatedTransaction,
    required this.radOrdDtlId,
    required this.resultEnteredBy,
    required this.resultEnteredDate,
    required this.resultEnteredTime,
    required this.siteId,
  });

  factory RadResultsModel.fromJson(Map<String, dynamic> json) {
    return RadResultsModel(
      type: json['type'] ?? '',
      boolean1: json['bolean1'],
      errNumber: json['errNumber'],
      str: json['str'] ?? '',
      str2: json['str2'] ?? '',
      value: json['value'],
      value3: json['value3'],
      auditFlag: json['auditFlag'],
      bodyText: json['bodyText'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creationDate: DateTime.parse(json['creationDate']),
      id: json['id'],
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
      lastUpdatedTransaction: json['lastUpdatedTransaction'] ?? '',
      radOrdDtlId: json['radOrdDtlId'],
      resultEnteredBy: json['resultEnteredBy'] ?? '',
      resultEnteredDate: DateTime.parse(json['resultEnteredDate']),
      resultEnteredTime: DateTime.parse(json['resultEnteredTime']),
      siteId: json['siteId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'bolean1': boolean1,
      'errNumber': errNumber,
      'str': str,
      'str2': str2,
      'value': value,
      'value3': value3,
      'auditFlag': auditFlag,
      'bodyText': bodyText,
      'createdBy': createdBy,
      'creationDate': creationDate.toIso8601String(),
      'id': id,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
      'lastUpdatedTransaction': lastUpdatedTransaction,
      'radOrdDtlId': radOrdDtlId,
      'resultEnteredBy': resultEnteredBy,
      'resultEnteredDate': resultEnteredDate.toIso8601String(),
      'resultEnteredTime': resultEnteredTime.toIso8601String(),
      'siteId': siteId,
    };
  }
}
