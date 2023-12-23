class PharmacyModel {
  final String type;
  final String desc; // 5
  final String desc1;
  final String counter;
  final String str;
  final int errNumber;
  final String doctorName; // 3
  final String dosageNo; // 2 + desc1 + counter
  final int dosageNoDays;
  final String dosageStartDate;
  final String dosageStartDateStr; // 4
  final String dosageStartTime; // + 4 (str صار)
  final String frequencyPerDay;
  final int frequencyDaily;
  final int id;
  final String orderDate;
  final String orderDateStr;
  final bool select;
  final String servCode;
  final String servDesc; // 1

  PharmacyModel({
    required this.type,
    required this.desc,
    required this.desc1,
    required this.counter,
    required this.str,
    required this.errNumber,
    required this.doctorName,
    required this.dosageNo,
    required this.dosageNoDays,
    required this.dosageStartDate,
    required this.dosageStartDateStr,
    required this.dosageStartTime,
    required this.frequencyPerDay,
    required this.frequencyDaily,
    required this.id,
    required this.orderDate,
    required this.orderDateStr,
    required this.select,
    required this.servCode,
    required this.servDesc,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      desc1: json['desc1'] ?? '',
      counter: json['counter'] ?? '',
      str: json['str'] ?? '',
      errNumber: json['errNumber'],
      doctorName: json['doctorName'] ?? '',
      dosageNo: json['dosageNo'] ?? '',
      dosageNoDays: json['dosageNoDays'],
      dosageStartDate: json['dosageStartDate'] ?? '',
      dosageStartDateStr: json['dosageStartDateStr'] ?? '',
      dosageStartTime: json['dosageStartTime'] ?? '',
      frequencyPerDay: json['frequancyPerDay'] ?? '',
      frequencyDaily: json['frequencyDaily'],
      id: json['id'],
      orderDate: json['orderDate'] ?? '',
      orderDateStr: json['orderDateStr'] ?? '',
      select: json['select'],
      servCode: json['servCode'] ?? '',
      servDesc: json['servDesc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'desc': desc,
      'desc1': desc1,
      'counter': counter,
      'str': str,
      'errNumber': errNumber,
      'doctorName': doctorName,
      'dosageNo': dosageNo,
      'dosageNoDays': dosageNoDays,
      'dosageStartDate': dosageStartDate,
      'dosageStartDateStr': dosageStartDateStr,
      'dosageStartTime': dosageStartTime,
      'frequencyPerDay': frequencyPerDay,
      'frequencyDaily': frequencyDaily,
      'id': id,
      'orderDate': orderDate,
      'orderDateStr': orderDateStr,
      'select': select,
      'servCode': servCode,
      'servDesc': servDesc,
    };
  }
}
