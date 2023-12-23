class InsuranceModel {
  final String insuranceCode;
  final int insuranceId;
  final String insuranceNameArb;

  InsuranceModel({
    required this.insuranceCode,
    required this.insuranceId,
    required this.insuranceNameArb,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    return InsuranceModel(
      insuranceCode: json['insuranceCode'] ?? '',
      insuranceId: json['insuranceId'] as int,
      insuranceNameArb: json['insuranceNameArb'] ?? '',
    );
  }

  // Method to convert Insurance instance to a map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'insuranceCode': insuranceCode,
      'insuranceId': insuranceId,
      'insuranceNameArb': insuranceNameArb,
    };
  }
}
