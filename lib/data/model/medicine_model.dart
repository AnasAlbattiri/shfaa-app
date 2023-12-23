class MedicineModel {
  final String type;
  final String desc;
  final int errNumber;
  final int value;
  final int value2;
  final int value3;
  final int dosageNoDays;
  final String str;
  final String dosageNumber;
  final String dosageStartDate;
  final String str2;
  final String str3;
  final String str4;
  final String str5;
  final String counter;
  final String notes;
  final String dosageStartDateStr;
  final String dosageStartTime;
  final int frequencyDaily;
  final int id;
  final int instraction;
  final String orderDate;
  final int quantity;
  final bool select;
  final String servCode;
  final String servDesc;

  MedicineModel({
    required this.str3,
    required this.dosageNumber,
    required this.str4,
    required this.str5,
    required this.counter,
    required this.notes,
    required this.type,
    required this.desc,
    required this.errNumber,
    required this.value,
    required this.value2,
    required this.value3,
    required this.dosageNoDays,
    required this.str,
    required this.dosageStartDate,
    required this.str2,
    required this.dosageStartDateStr,
    required this.dosageStartTime,
    required this.frequencyDaily,
    required this.id,
    required this.instraction,
    required this.orderDate,
    required this.quantity,
    required this.select,
    required this.servCode,
    required this.servDesc,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      dosageNumber: json['dosageNo'],
      errNumber: json['errNumber'],
      value: json['value'],
      value2: json['value2'],
      value3: json['value3'],
      dosageNoDays: json['dosageNoDays'],
      str: json['str'] ?? '',
      str3: json['str3'] ?? '',
      str4: json['str4'] ?? '',
      str5: json['str5'] ?? '',
      counter: json['counter'] ?? '',
      notes: json['notes'] ?? '',
      dosageStartDate: json['dosageStartDate'] ?? '',
      str2: json['str2'] ?? '',
      dosageStartDateStr: json['dosageStartDateStr'] ?? '',
      dosageStartTime: json['dosageStartTime'] ?? '',
      frequencyDaily: json['frequencyDaily'],
      id: json['id'],
      instraction: json['instraction'],
      orderDate: json['orderDate'] ?? '',
      quantity: json['quntity'],
      select: json['select'],
      servCode: json['servCode'] ?? '',
      servDesc: json['servDesc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'desc': desc,
      'errNumber': errNumber,
      'value': value,
      'value2': value2,
      'value3': value3,
      'dosageNoDays': dosageNoDays,
      'str': str,
      'dosageStartDate': dosageStartDate,
      'str2': str2,
      'str3': str3,
      'str4': str4,
      'str5': str5,
      'counter': counter,
      'notes': notes,
      'dosageStartDateStr': dosageStartDateStr,
      'dosageStartTime': dosageStartTime,
      'frequencyDaily': frequencyDaily,
      'id': id,
      'instraction': instraction,
      'orderDate': orderDate,
      'quantity': quantity,
      'select': select,
      'servCode': servCode,
      'servDesc': servDesc,
    };
  }
}
