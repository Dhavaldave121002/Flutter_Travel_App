import 'package:flutter/material.dart';

class QRCodePage extends StatelessWidget {
  final String totalBalance; // Total balance of the admin's account

  QRCodePage({
    String? totalBalance, // Make totalBalance optional
    required String amount,
    required String imageUrl,
  }) : totalBalance = (totalBalance == null || totalBalance.isEmpty)
            ? '0'
            : totalBalance; // Default to '0' if null or empty

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Account Balance'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '₹$totalBalance', // Display the total balance
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        _transferAmount(context); // Call the transfer function
                      },
                      icon: Icon(Icons.transfer_within_a_station),
                      label: Text('Transfer to Bank'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        backgroundColor: Colors.blue, // Change color as needed
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Go back to the previous page
                      },
                      child: Text('Back'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _transferAmount(BuildContext context) {
    // Here you can implement the actual transfer logic
    // For demonstration, we will show a success message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transfer Amount'),
          content: Text('Successfully transferred ₹$totalBalance to the bank!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
