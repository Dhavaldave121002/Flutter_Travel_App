import 'package:flutter/material.dart';
import 'user.dart'; // Import User model
import 'userprofile.dart'; // Import UserProfile class
import 'login_page.dart'; // Import LoginPage class
import 'QRCodePage.dart'; // Import QRCodePage class (for QR code generation)
import 'ContectDetailPage.dart'; // Import the ContactDetailsPage

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<User> users = [
    User(
        username: 'User    1',
        email: 'user1@example.com',
        mobileNumber: '1234567890',
        dob: '2000-01-01',
        password: 'password1'),
    User(
        username: 'User    2',
        email: 'user2@example.com',
        mobileNumber: '0987654321',
        dob: '1995-05-05',
        password: 'password2'),
  ];

  List<User> filteredUsers = [];
  String searchQuery = '';
  double totalPaymentAmount = 0.0; // Variable to store total payment amount

  // Sample contact details for demonstration
  List<Map<String, String>> contactDetails = [
    {'name': 'John Doe', 'email': 'john@example.com', 'message': 'Hello!'},
    {
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'message': 'Need help!'
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredUsers =
        List.from(users); // Initialize filtered users with all users
  }

  void _removeUser(User user) {
    setState(() {
      users.remove(user);
      filteredUsers.remove(user);
    });
  }

  void _viewUserDetails(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfile(
          username: user.username,
          email: user.email,
          mobileNumber: user.mobileNumber,
          dob: user.dob,
          user: user, // Pass the user object
          password: user.password,
        ),
      ),
    );
  }

  void _filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addUser() {
    // Show a dialog to add a new user
    String username = '';
    String email = '';
    String mobileNumber = '';
    String dob = '';
    String password = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  username = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                onChanged: (value) {
                  mobileNumber = value;
                },
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                onChanged: (value) {
                  dob = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (username.isNotEmpty &&
                    email.isNotEmpty &&
                    mobileNumber.isNotEmpty &&
                    dob.isNotEmpty &&
                    password.isNotEmpty) {
                  setState(() {
                    User newUser = User(
                      username: username,
                      email: email,
                      mobileNumber: mobileNumber,
                      dob: dob,
                      password: password,
                    );
                    users.add(newUser);
                    filteredUsers.add(newUser); // Add to filtered users as well
                  });
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Add User'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without adding
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginPage(), // Ensure LoginPage can handle the transition
      ),
    );
  }

  void _generateQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodePage(
          amount: '',
          imageUrl: '',
          totalBalance: '',
        ), // Navigate to QRCodePage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Admin Page'),
            Container(
              width: 200, // Set a specific width for the search bar
              child: TextField(
                onChanged: _filterUsers,
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addUser, // Call the add user function
          ),
          IconButton(
            icon: Icon(Icons.account_balance_wallet, size: 30), // Wallet icon
            onPressed: _generateQRCode, // Navigate to QRCodePage
          ),
          IconButton(
            icon: Icon(Icons.contact_page, size: 30), // Contact details icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContectDetailsPage(
                      contactDetails:
                          contactDetails), // Pass the contact details
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4, // Add shadow for depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(user.username),
                      subtitle: Text(user.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              _removeUser(user); // Remove the user directly
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () => _viewUserDetails(user),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _login, // Call the login function
                child: Text('Back to Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
