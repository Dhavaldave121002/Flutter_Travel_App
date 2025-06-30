class User {
  final String username;
  final String email;
  final String mobileNumber;
  final String dob;
  final String password; // Added password field

  User({
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.dob,
    required this.password, // Include password in constructor
  });
}
