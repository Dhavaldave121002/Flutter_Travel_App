import 'package:flutter/material.dart';

class ContectDetailsPage extends StatelessWidget {
  final List<Map<String, String>> contactDetails;

  ContectDetailsPage({required this.contactDetails});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: contactDetails.length,
          itemBuilder: (context, index) {
            final contact = contactDetails[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  contact['name'] ?? 'No Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05, // Responsive font size
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      contact['email'] ?? 'No Email',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: screenWidth * 0.04, // Responsive font size
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      contact['message'] ?? 'No Message',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: screenWidth * 0.04, // Responsive font size
                      ),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
