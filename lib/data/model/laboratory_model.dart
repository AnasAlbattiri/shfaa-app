class LaboratoryModel {
  final String type;
  final String desc;
  final String str;
  final int errNumber;
  final int value;
  final int labTestCat; // lab test category
  final int labTestResultType; // lab test result type
  final int profileId; // profile id
  final int machineId; // machine id
  final int machineKitId;
  final int siteId;
  final String doctorName;
  final String colonyCount;
  final String bectiriaTypeStr;
  final String originSpecStr;
  final int id;
  final String listFormate;
  final String orderDate;
  final String orderDateStr;
  final int orderId;
  final String orderTime;
  final int repeatNo;
  final bool select;
  final String servCode;
  final String servDesc;
  final int labTestId;
  final int value4;

  LaboratoryModel({
    required this.type,
    required this.desc,
    required this.str,
    required this.errNumber,
    required this.value,
    required this.labTestCat,
    required this.labTestResultType,
    required this.profileId,
    required this.machineId,
    required this.machineKitId,
    required this.siteId,
    required this.doctorName,
    required this.bectiriaTypeStr,
    required this.colonyCount,
    required this.originSpecStr,
    required this.id,
    required this.listFormate,
    required this.orderDate,
    required this.orderDateStr,
    required this.orderId,
    required this.orderTime,
    required this.repeatNo,
    required this.select,
    required this.servCode,
    required this.servDesc,
    required this.labTestId,
    required this.value4,
  });

  factory LaboratoryModel.fromJson(Map<String, dynamic> json) {
    return LaboratoryModel(
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      str: json['str'] ?? '',
      errNumber: json['errNumber'] ?? 0,
      value: json['value'] ?? 0,
      labTestCat: json['labTestCat'] ?? 0,
      labTestResultType: json['labTestResultType'] ?? 0,
      profileId: json['profileId'] ?? 0,
      machineId: json['machineId'] ?? 0,
      machineKitId: json['machineKitId'] ?? 0,
      siteId: json['siteId'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      colonyCount: json['colonyCount'] ?? '',
      bectiriaTypeStr: json['bectiriaTypeStr'] ?? '',
      originSpecStr: json['originSpecStr'] ?? '',
      id: json['id'] ?? 0,
      listFormate: json['listFormate'] ?? '',
      orderDate: json['orderDate'] ?? '',
      orderDateStr: json['orderDateStr'] ?? '',
      orderId: json['orderId'] ?? 0,
      orderTime: json['orderTime'] ?? '',
      repeatNo: json['repeatNo'] ?? 0,
      value4: json['value4'] ?? 0,
      labTestId: json['labTestId'] ?? 0,
      select: json['select'],
      servCode: json['servCode'] ?? '',
      servDesc: json['servDesc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'desc': desc,
      'str': str,
      'errNumber': errNumber,
      'value': value,
      'labTestCat': labTestCat,
      'labTestResultType': labTestResultType,
      'profileId': profileId,
      'machineId': machineId,
      'machineKitId': machineKitId,
      'siteId': siteId,
      'doctorName': doctorName,
      'bectiriaTypeStr': bectiriaTypeStr,
      'originSpecStr': originSpecStr,
      'value4': value4,
      'colonyCount': colonyCount,
      'id': id,
      'labTestId': labTestId,
      'listFormate': listFormate,
      'orderDate': orderDate,
      'orderDateStr': orderDateStr,
      'orderId': orderId,
      'orderTime': orderTime,
      'repeatNo': repeatNo,
      'select': select,
      'servCode': servCode,
      'servDesc': servDesc,
    };
  }
}
