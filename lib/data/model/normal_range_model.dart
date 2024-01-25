class NormalRangeModel {
  String type;
  int errNumber;
  String str;
  int fromAgeD;
  int fromAgeM;
  int fromAgeWeek;
  int fromAgeY;
  int id;
  int labTestId;
  String lowerLimit;
  int toAgeD;
  int toAgeM;
  int toAgeWeek;
  int toAgeY;
  String upperLimit;
  int? countryValue;
  String? createdBy;
  DateTime? creationDate;
  int? kitValue;
  int? labRangeStatus;
  int? sex;
  int? siteId;
  String? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  String? lastUpdatedTransaction;
  String? upperLowerNote;

  NormalRangeModel({
    required this.type,
    required this.errNumber,
    required this.str,
    required this.fromAgeD,
    required this.fromAgeM,
    required this.fromAgeWeek,
    required this.fromAgeY,
    required this.id,
    required this.labTestId,
    required this.lowerLimit,
    required this.toAgeD,
    required this.toAgeM,
    required this.toAgeWeek,
    required this.toAgeY,
    required this.upperLimit,
    this.countryValue,
    this.createdBy,
    this.creationDate,
    this.kitValue,
    this.labRangeStatus,
    this.sex,
    this.siteId,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.lastUpdatedTransaction,
    this.upperLowerNote,
  });

  factory NormalRangeModel.fromJson(Map<String, dynamic> json) {
    return NormalRangeModel(
      type: json['type'],
      errNumber: json['errNumber'],
      str: json['str'],
      fromAgeD: json['fromAgeD'],
      fromAgeM: json['fromAgeM'],
      fromAgeWeek: json['fromAgeWeek'],
      fromAgeY: json['fromAgeY'],
      id: json['id'],
      labTestId: json['labTestId'],
      lowerLimit: json['lowerLimit'],
      toAgeD: json['toAgeD'],
      toAgeM: json['toAgeM'],
      toAgeWeek: json['toAgeWeek'],
      toAgeY: json['toAgeY'],
      upperLimit: json['upperLimit'],
      countryValue: json['countryValue'],
      createdBy: json['createdBy'],
      creationDate: DateTime.parse(json['creationDate']),
      kitValue: json['kitValue'],
      labRangeStatus: json['labRangeStatus'],
      sex: json['sex'],
      siteId: json['siteId'],
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
      lastUpdatedTransaction: json['lastUpdatedTransaction'],
      upperLowerNote: json['upperLowerNote'],
    );
  }
}
