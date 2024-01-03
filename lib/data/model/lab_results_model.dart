class LaboratoryResultsModel {
  String type;
  int errNumber;
  String result;
  int value;
  int value2;
  int value3;
  int value5;
  int value6;
  bool abnormalFlagB;
  bool auditFlag;
  String createdBy;
  DateTime creationDate;
  String examinedBy;
  int id;
  int labTestId;
  int labTestResultType;
  String lastUpdatedBy;
  DateTime lastUpdatedDate;
  String lastUpdatedTransaction;
  int orderDtlId;
  String resultEnteredBy;
  DateTime resultTime;
  int siteId;
  String testCode;
  String textResult;

  LaboratoryResultsModel({
    required this.type,
    required this.errNumber,
    required this.result,
    required this.value,
    required this.value2,
    required this.value3,
    required this.value5,
    required this.value6,
    required this.abnormalFlagB,
    required this.auditFlag,
    required this.createdBy,
    required this.creationDate,
    required this.examinedBy,
    required this.id,
    required this.labTestId,
    required this.labTestResultType,
    required this.lastUpdatedBy,
    required this.lastUpdatedDate,
    required this.lastUpdatedTransaction,
    required this.orderDtlId,
    required this.resultEnteredBy,
    required this.resultTime,
    required this.siteId,
    required this.testCode,
    required this.textResult,
  });

  factory LaboratoryResultsModel.fromJson(Map<String, dynamic> json) {
    return LaboratoryResultsModel(
      type: json['type'],
      errNumber: json['errNumber'],
      result: json['result'],
      value: json['value'],
      value2: json['value2'],
      value3: json['value3'],
      value5: json['value5'],
      value6: json['value6'],
      abnormalFlagB: json['abnormalFlagB'],
      auditFlag: json['auditFlag'],
      createdBy: json['createdBy'],
      creationDate: DateTime.parse(json['creationDate']),
      examinedBy: json['examinedBy'],
      id: json['id'],
      labTestId: json['labTestId'],
      labTestResultType: json['labTestResultType'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
      lastUpdatedTransaction: json['lastUpdatedTransaction'],
      orderDtlId: json['orderDtlId'],
      resultEnteredBy: json['resultEnteredBy'],
      resultTime: DateTime.parse(json['resultTime']),
      siteId: json['siteId'],
      testCode: json['testCode'],
      textResult: json['textResult'],
    );
  }
}
