class User {
  final String fullName;
  final String email;
  final String role;
  final String? subject;
  final String? batch;
  final String phone;
  final String address;
  final DateTime dob;

  User({
    required this.fullName,
    required this.email,
    required this.role,
    this.subject,
    this.batch,
    required this.phone,
    required this.address,
    required this.dob,
  });
}