class RadiationModel {
  final String type;
  final int errNumber;
  final String result; // 2
  final String str;
  final String bodySectionDesc;
  final String bodySideDesc;
  final int id;
  final String orderDate; // 4
  final String orderDateStr;
  final int orderId;
  final String orderStatusDesc; // 3
  final String orderTime; // 5
  final int repeatNo;
  final bool select;
  final bool selectFlag;
  final String testDesc; // 1
  final String urgencyDesc;
  final int urgencyLevel;

  RadiationModel({
    required this.type,
    required this.str,
    required this.errNumber,
    required this.result,
    required this.bodySectionDesc,
    required this.bodySideDesc,
    required this.id,
    required this.orderDate,
    required this.orderDateStr,
    required this.orderId,
    required this.orderStatusDesc,
    required this.orderTime,
    required this.repeatNo,
    required this.select,
    required this.selectFlag,
    required this.testDesc,
    required this.urgencyDesc,
    required this.urgencyLevel,
  });

  factory RadiationModel.fromJson(Map<String, dynamic> json) {
    return RadiationModel(
      type: json['type'] ?? '',
      errNumber: json['errNumber'] ?? 0,
      str: json['str'] ?? 0,
      result: json['result'] ?? '',
      bodySectionDesc: json['bodySectionDesc'] ?? '',
      bodySideDesc: json['bodySideDesc'] ?? '',
      id: json['id'] ?? 0,
      orderDate: json['orderDate'] ?? '',
      orderDateStr: json['orderDateStr'] ?? '',
      orderId: json['orderId'] ?? 0,
      orderStatusDesc: json['orderStatusDesc'] ?? '',
      orderTime: json['orderTime'] ?? '',
      repeatNo: json['repeatNo'] ?? 0,
      select: json['select'] ?? false,
      selectFlag: json['selectFlag'] ?? false,
      testDesc: json['testDesc'] ?? '',
      urgencyDesc: json['urgencyDesc'] ?? '',
      urgencyLevel: json['urgencyLevel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'errNumber': errNumber,
      'str': str,
      'result': result,
      'bodySectionDesc': bodySectionDesc,
      'bodySideDesc': bodySideDesc,
      'id': id,
      'orderDate': orderDate,
      'orderDateStr': orderDateStr,
      'orderId': orderId,
      'orderStatusDesc': orderStatusDesc,
      'orderTime': orderTime,
      'repeatNo': repeatNo,
      'select': select,
      'selectFlag': selectFlag,
      'testDesc': testDesc,
      'urgencyDesc': urgencyDesc,
      'urgencyLevel': urgencyLevel,
    };
  }
}
