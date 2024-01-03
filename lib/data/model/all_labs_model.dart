class AllLabsModel {
  final String type;
  final String desc;
  final String str;
  final int errNumber;
  final int value;
  final String doctorName; // 2
  final int id;
  final String listFormate; // 3
  final String orderDate; // 4
  final String orderDateStr;
  final int orderId;
  final String orderTime; // 5
  final int repeatNo;
  final bool select;
  final String servCode;
  final String servDesc; // 1

  AllLabsModel({
    required this.type,
    required this.desc,
    required this.str,
    required this.errNumber,
    required this.value,
    required this.doctorName,
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
  });

  factory AllLabsModel.fromJson(Map<String, dynamic> json) {
    return AllLabsModel(
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      str: json['str'] ?? '',
      errNumber: json['errNumber'] ?? 0,
      value: json['value'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      id: json['id'] ?? 0,
      listFormate: json['listFormate'] ?? '',
      orderDate: json['orderDate'] ?? '',
      orderDateStr: json['orderDateStr'] ?? '',
      orderId: json['orderId'] ?? 0,
      orderTime: json['orderTime'] ?? '',
      repeatNo: json['repeatNo'] ?? 0,
      select: json['select'] ?? false,
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
      'doctorName': doctorName,
      'id': id,
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
