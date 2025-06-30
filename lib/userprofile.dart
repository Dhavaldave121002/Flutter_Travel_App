// user_profile.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Import the LoginPage class
import 'wallet_page.dart'; // Import the WalletPage class

class UserProfile extends StatefulWidget {
  final String username;
  final String email;
  final String mobileNumber;
  final String dob;

  UserProfile({
    super.key,
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.dob,
    required user,
    required String password,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumberController;
  late TextEditingController dobController;

  bool isEditingUsername = false;
  bool isEditingEmail = false;
  bool isEditingMobileNumber = false;
  bool isEditingDob = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
    mobileNumberController = TextEditingController(text: widget.mobileNumber);
    dobController = TextEditingController(text: widget.dob);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('mobileNumber', mobileNumberController.text);
    await prefs.setString('dob', dobController.text);
  }

  void _logout() async {
    // Clear the text fields
    usernameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    dobController.clear();

    // Optionally, clear user data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('mobileNumber');
    await prefs.remove('dob');

    // Navigate to the home page (LoginPage in this case)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      setState(() {
        dobController.text =
            formattedDate; // Set the selected date to the TextField
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('User  Profile'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet), // Wallet icon
            onPressed: () {
              // Navigate to Wallet Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout), // Icon to represent logout
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User  Profile',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.06,
                      fontWeight: FontWeight.bold), // Responsive font size
                ),
                SizedBox(
                    height: screenSize.height * 0.02), // Responsive spacing
                _buildEditableTextField(
                  controller: usernameController,
                  label: 'Username',
                  isEditing: isEditingUsername,
                  onEditToggle: () {
                    setState(() {
                      isEditingUsername = !isEditingUsername;
                      if (!isEditingUsername) {
                        _saveUserData(); // Save data when editing is finished
                      }
                    });
                  },
                ),
                SizedBox(
                    height: screenSize.height * 0.01), // Responsive spacing
                _buildEditableTextField(
                  controller: emailController,
                  label: 'Email',
                  isEditing: isEditingEmail,
                  onEditToggle: () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                      if (!isEditingEmail) {
                        _saveUserData(); // Save data when editing is finished
                      }
                    });
                  },
                ),
                SizedBox(
                    height: screenSize.height * 0.01), // Responsive spacing
                _buildEditableTextField(
                  controller: mobileNumberController,
                  label: 'Mobile Number',
                  isEditing: isEditingMobileNumber,
                  onEditToggle: () {
                    setState(() {
                      isEditingMobileNumber = !isEditingMobileNumber;
                      if (!isEditingMobileNumber) {
                        _saveUserData(); // Save data when editing is finished
                      }
                    });
                  },
                ),
                SizedBox(
                    height: screenSize.height * 0.01), // Responsive spacing
                _buildEditableTextField(
                  controller: dobController,
                  label: 'Date of Birth',
                  isEditing: isEditingDob,
                  onEditToggle: () {
                    if (isEditingDob) {
                      _selectDate(context); // Show date picker when editing
                    } else {
                      setState(() {
                        isEditingDob = !isEditingDob;
                        if (!isEditingDob) {
                          _saveUserData(); // Save data when editing is finished
                        }
                      });
                    }
                  },
                ),
                SizedBox(
                    height: screenSize.height * 0.02), // Responsive spacing
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Wallet Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WalletPage()),
                    );
                  },
                  child: Text('Go to Wallet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Set the button color
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.1,
                      vertical: 15,
                    ), // Responsive padding
                  ),
                ),
                SizedBox(
                    height: screenSize.height * 0.02), // Responsive spacing
                ElevatedButton(
                  onPressed: _logout,
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set the button color
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.1,
                      vertical: 15,
                    ), // Responsive padding
                  ),
                ),
                SizedBox(
                    height: screenSize.height * 0.02), // Responsive spacing
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Home Page
                    Navigator.pop(context);
                  },
                  child: Text('Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set the button color
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.1,
                      vertical: 15,
                    ), // Responsive padding
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String label,
    required bool isEditing,
    required VoidCallback onEditToggle,
  }) {
    return Card(
      elevation: 4,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: !isEditing,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: onEditToggle,
          ),
        ],
      ),
    );
  }
}
