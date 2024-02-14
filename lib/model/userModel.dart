// ignore_for_file: file_names

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final DateTime timestamp;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.timestamp,
  });

  // Convert the SignupUser object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'timestamp': timestamp,
    };
  }
}
