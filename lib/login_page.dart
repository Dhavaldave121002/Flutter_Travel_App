import 'package:flutter/material.dart';
import 'registration_page.dart'; // Import the RegistrationPage class
import 'home_page.dart'; // Import the HomePage class
import 'admin_page.dart'; // Import the AdminPage class
import 'forgot_password_page.dart'; // Import the ForgotPasswordPage class
import 'dart:math'; // Import for random number generation
import 'dart:async'; // Import for Timer

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define default admin credentials
  final String adminUsername = "admin";
  final String adminPassword =
      "admin123"; // Change this to your desired admin password

  // State variable to manage password visibility
  bool _isPasswordVisible = false;

  // CAPTCHA variables
  String _captcha = '';
  Timer? _captchaTimer;

  @override
  void initState() {
    super.initState();
    _generateCaptcha(); // Generate CAPTCHA when the page is initialized
    _startCaptchaTimer(); // Start the timer for CAPTCHA refresh
  }

  void _startCaptchaTimer() {
    _captchaTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      _generateCaptcha(); // Regenerate CAPTCHA every minute
    });
  }

  void _generateCaptcha() {
    // Generate a random 6-digit number as CAPTCHA
    _captcha = (Random().nextInt(900000) + 100000).toString();
    setState(() {}); // Update the UI to show the new CAPTCHA
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Check if the entered CAPTCHA is correct
      if (_captchaController.text != _captcha) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect CAPTCHA. Please try again.')),
        );
        return; // Stop the login process if CAPTCHA is incorrect
      }

      // Check if the entered credentials match the admin credentials
      if (username == adminUsername && password == adminPassword) {
        // Navigate to AdminPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
      // Check if the entered password matches the registered password
      else if (password == RegistrationPage.registeredPassword) {
        // Here you can add your login logic (e.g., API call)
        print('Username: $username, Password: $password');

        // Navigate to HomePage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show an error message if the password does not match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Incorrect username or password. Please try again.')),
        );
      }
    } else {
      // If the form is not valid, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
  }

  @override
  void dispose() {
    _captchaTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding:
                EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    screenSize.width * 0.05), // Responsive padding
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize:
                              screenSize.width * 0.07, // Responsive text size
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.02), // Responsive spacing
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.lightBlue[50],
                          prefixIcon: Icon(Icons.person,
                              color: Colors.blueAccent), // Icon for username
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.02), // Responsive spacing
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.lightBlue[50],
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          prefixIcon: Icon(Icons.lock,
                              color: Colors.blueAccent), // Icon for password
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.02), // Responsive spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CAPTCHA: $_captcha',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh, color: Colors.blueAccent),
                            onPressed: _generateCaptcha, // Refresh CAPTCHA
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.02), // Responsive spacing
                      TextFormField(
                        controller: _captchaController,
                        decoration: InputDecoration(
                          labelText: 'Enter CAPTCHA',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.lightBlue[50],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the CAPTCHA';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.02), // Responsive spacing
                      ElevatedButton(
                        onPressed: () => _login(context),
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.1, vertical: 15),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ), // Button color
                        ),
                      ),
                      SizedBox(
                          height:
                              screenSize.height * 0.01), // Responsive spacing
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()),
                          );
                        },
                        child: Text('Don\'t have an account? Register',
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Text('Forgot Password?',
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
