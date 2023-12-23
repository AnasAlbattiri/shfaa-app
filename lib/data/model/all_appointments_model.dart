class AllAppointmentModel {
  final int apptId;
  final String resourceDate;
  final int siteId;
  final String startTime;
  final int superResRefTransId;

  AllAppointmentModel({
    required this.apptId,
    required this.resourceDate,
    required this.siteId,
    required this.startTime,
    required this.superResRefTransId,
  });

  factory AllAppointmentModel.fromJson(Map<String, dynamic> json) {
    return AllAppointmentModel(
      apptId: json['apptId'],
      resourceDate: json['resourceDate'] ?? '',
      siteId: json['siteId'],
      startTime: json['startTime'] ?? '',
      superResRefTransId: json['superResRefTransId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apptId': apptId,
      'resourceDate': resourceDate,
      'siteId': siteId,
      'startTime': startTime,
      'superResRefTransId': superResRefTransId,
    };
  }
}

