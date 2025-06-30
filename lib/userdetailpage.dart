import 'package:flutter/material.dart';
import 'userprofile.dart'; // Import the UserProfileDisplayPage class

class UserDetailpage extends StatefulWidget {
  static String?
      registeredUsername; // Static variable to hold registered username

  @override
  _UserDetailpageState createState() => _UserDetailpageState();
}

class _UserDetailpageState extends State<UserDetailpage> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;

      // Store the registered username in the static variable
      UserDetailpage.registeredUsername = username;

      // Navigate to the user profile display page after registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfile(
                  username: '',
                  email: '',
                  mobileNumber: '',
                  dob: '',
                  user: null,
                  password: '',
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User  Profile Registration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the login page (not implemented in this example)
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
