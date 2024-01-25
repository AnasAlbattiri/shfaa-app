class LabGroupModel {
  String? createdBy;
  DateTime? creationDate;
  String? examinedBy;
  int? groupRsltId;
  int? id;
  int? labTestId;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? lastUpdatedTransaction;
  double? numericResult;
  int? orderDtlId;
  DateTime? resultDate;
  DateTime? resultTime;
  int? siteId;
  String? textResult;
  int? labResultList;
  String? auditBy;
  bool? auditFlag;
  DateTime? auditDate;
  int? repeatNo;
  int? abnormalFlag;

  LabGroupModel({
    this.createdBy,
    this.creationDate,
    this.examinedBy,
    this.groupRsltId,
    this.id,
    this.labTestId,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.lastUpdatedTransaction,
    this.numericResult,
    this.orderDtlId,
    this.resultDate,
    this.resultTime,
    this.siteId,
    this.textResult,
    this.labResultList,
    this.auditBy,
    this.auditFlag,
    this.auditDate,
    this.repeatNo,
    this.abnormalFlag,
  });

  factory LabGroupModel.fromJson(Map<String, dynamic> json) {
    return LabGroupModel(
      createdBy: json['createdBy'],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      examinedBy: json['examinedBy'],
      groupRsltId: json['groupRsltId'],
      id: json['id'],
      labTestId: json['labTestId'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: json['lastUpdatedDate'] != null
          ? DateTime.parse(json['lastUpdatedDate'])
          : null,
      lastUpdatedTransaction: json['lastUpdatedTransaction'],
      numericResult: json['numericResult']?.toDouble(),
      orderDtlId: json['orderDtlId'],
      resultDate: json['resultDate'] != null
          ? DateTime.parse(json['resultDate'])
          : null,
      resultTime: json['resultTime'] != null
          ? DateTime.parse(json['resultTime'])
          : null,
      siteId: json['siteId'],
      textResult: json['textResult'],
      labResultList: json['labResultList'],
      auditBy: json['auditBy'],
      auditFlag: json['auditFlag'],
      auditDate: json['auditDate'] != null
          ? DateTime.parse(json['auditDate'])
          : null,
      repeatNo: json['repeatNo'],
      abnormalFlag: json['abnormalFlag'],
    );
  }
}
