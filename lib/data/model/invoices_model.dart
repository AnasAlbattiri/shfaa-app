class InvoicesModel {
  final int id;
  final String invoiceDate;
  final String invoiceNo;
  final String locationDescArb;
  final String locationDescEng;
  final int encounterId;

  InvoicesModel({
    required this.id,
    required this.invoiceDate,
    required this.invoiceNo,
    required this.locationDescArb,
    required this.locationDescEng,
    required this.encounterId,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) {
    return InvoicesModel(
      id: json['id'],
      invoiceDate: json['invoiceDate'] ?? '',
      invoiceNo: json['invoiceNo'] ?? '',
      locationDescArb: json['locationDescArb'] ?? '',
      locationDescEng: json['locationDescEng'] ?? '',
      encounterId: json['encounterId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceDate': invoiceDate,
      'invoiceNo': invoiceNo,
      'locationDescArb': locationDescArb,
      'locationDescEng': locationDescEng,
      'encounterId': encounterId,
    };
  }

  @override
  String toString() {
    return 'InvoicesModel{id: $id, invoiceDate: $invoiceDate, invoiceNo: $invoiceNo, locationDescArb: $locationDescArb, locationDescEng: $locationDescEng, encounterId: $encounterId}';
  }
}
