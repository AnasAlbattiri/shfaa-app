class UserPatientModel {
  final String userId;
  final String userName;
  final String userPassword;
  final int active;
  final int patientId;

  UserPatientModel({
    required this.userId,
    required this.userName,
    required this.userPassword,
    required this.active,
    required this.patientId,
  });

  factory UserPatientModel.fromJson(Map<String, dynamic> json) {
    return UserPatientModel(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPassword: json['userPassword'] ?? '',
      active: json['active'],
      patientId: json['patientId'],
    );
  }
}
