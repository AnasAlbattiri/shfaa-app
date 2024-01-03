class InvoicesModel {
  final String invoiceDate;
  final String invoiceNo;
  final String locationDescArb;
  final String locationDescEng;
  final double amount;
  final int encounterId;

  InvoicesModel({
    required this.invoiceDate,
    required this.invoiceNo,
    required this.locationDescArb,
    required this.locationDescEng,
    required this.amount,
    required this.encounterId,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) {
    return InvoicesModel(
      invoiceDate: json['invoiceDate'] ?? '',
      invoiceNo: json['invoiceNo'] ?? '',
      locationDescArb: json['locationDescArb'] ?? '',
      locationDescEng: json['locationDescEng'] ?? '',
      amount: json['amount'] ?? 0,
      encounterId: json['encounterId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoiceDate': invoiceDate,
      'invoiceNo': invoiceNo,
      'locationDescArb': locationDescArb,
      'locationDescEng': locationDescEng,
      'amount': amount,
      'encounterId': encounterId,
    };
  }

  @override
  String toString() {
    return 'InvoicesModel{invoiceDate: $invoiceDate, invoiceNo: $invoiceNo, locationDescArb: $locationDescArb, locationDescEng: $locationDescEng, encounterId: $encounterId, amount: $amount}';
  }
}
