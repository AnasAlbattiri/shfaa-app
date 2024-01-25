class LaboratoryResultsModel {
  int? antibioticValue;
  String? auditBy;
  DateTime? auditDate;
  bool? intermediateFlag;
  String? notes;
  bool? resistantFlag;
  DateTime? resultDate;
  bool? sensitiveFlag;
  bool? selectFlag;
  int? bacteriaType;
  String? originOfSpecimen;
  String? colonyCount;
  int? priority;
  String? type;
  int? errNumber;
  String? result;
  int? value;
  int? value2;
  int? value3;
  int? value5;
  int? value6;
  bool? abnormalFlagB;
  bool? auditFlag;
  String? createdBy;
  DateTime? creationDate;
  String? examinedBy;
  int? id;
  int? labTestId;
  int? labTestResultType;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? lastUpdatedTransaction;
  int? orderDtlId;
  String? resultEnteredBy;
  DateTime? resultTime;
  int? siteId;
  String? unit;
  double? numericResult;
  String? testCode;
  String? textResult;

  LaboratoryResultsModel({
    this.antibioticValue,
    this.auditBy,
    this.auditDate,
    this.intermediateFlag,
    this.unit,
    this.notes,
    this.resistantFlag,
    this.resultDate,
    this.sensitiveFlag,
    this.selectFlag,
    this.bacteriaType,
    this.originOfSpecimen,
    this.colonyCount,
    this.priority,
    this.type,
    this.errNumber,
    this.result,
    this.value,
    this.value2,
    this.value3,
    this.value5,
    this.value6,
    this.abnormalFlagB,
    this.numericResult,
    this.auditFlag,
    this.createdBy,
    this.creationDate,
    this.examinedBy,
    this.id,
    this.labTestId,
    this.labTestResultType,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.lastUpdatedTransaction,
    this.orderDtlId,
    this.resultEnteredBy,
    this.resultTime,
    this.siteId,
    this.testCode,
    this.textResult,
  });

  factory LaboratoryResultsModel.fromJson(Map<String, dynamic> json) {
    return LaboratoryResultsModel(
      antibioticValue: json['antibioticValue'],
      auditBy: json['auditBy'],
      auditDate: json['auditDate'] != null
          ? DateTime.parse(json['auditDate'])
          : null,
      intermediateFlag: json['intermediateFlag'],
      notes: json['notes'],
      resistantFlag: json['resistantFlag'],
      resultDate: json['resultDate'] != null
          ? DateTime.parse(json['resultDate'])
          : null,
      sensitiveFlag: json['sensitiveFlag'],
      selectFlag: json['selectFlag'],
      bacteriaType: json['bacteriaType'],
      originOfSpecimen: json['originOfSpecimen'],
      colonyCount: json['colonyCount'],
      priority: json['priority'],
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
      unit: json['unit'],
      createdBy: json['createdBy'],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      examinedBy: json['examinedBy'],
      id: json['id'],
      labTestId: json['labTestId'],
      labTestResultType: json['labTestResultType'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: json['lastUpdatedDate'] != null
          ? DateTime.parse(json['lastUpdatedDate'])
          : null,
      lastUpdatedTransaction: json['lastUpdatedTransaction'],
      orderDtlId: json['orderDtlId'],
      numericResult: json['numericResult'],
      resultEnteredBy: json['resultEnteredBy'],
      resultTime: json['resultTime'] != null
          ? DateTime.parse(json['resultTime'])
          : null,
      siteId: json['siteId'],
      testCode: json['testCode'],
      textResult: json['textResult'],
    );
  }
}
