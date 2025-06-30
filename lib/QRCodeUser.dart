import 'package:flutter/material.dart';
import 'TravelHistoryPage.dart'; // Import the TravelHistoryPage

class QRCodeUser extends StatefulWidget {
  final String amount; // Amount to be paid
  final String destination; // Destination selected by the user
  final String totalBalance; // User's total balance

  QRCodeUser({
    required this.amount,
    required this.destination,
    required String imageUrl,
    required this.totalBalance,
  });

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodeUser> {
  String paymentMethod = 'Google Pay'; // Default payment method
  String qrData = ''; // Data to be encoded in QR code
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Method to get the image path based on the selected payment method
  String _getPaymentImage() {
    switch (paymentMethod) {
      case 'Google Pay':
        return 'assets/payment_image.jpeg'; // Path for Google Pay image
      case 'PhonePe':
        return 'assets/payment2_image.jpeg'; // Path for PhonePe image
      case 'Wallet':
        return ''; // No image for wallet payment
      default:
        return ''; // No image for card payment
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
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
                    // Display amount in rupees
                    Text(
                      'Total Amount: ₹${widget.amount}', // Changed to display in rupees
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Display User's Wallet Balance
                    Text(
                      'Your Wallet Balance: ₹${widget.totalBalance}',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    SizedBox(height: 20),
                    // Payment Method Selector
                    DropdownButton<String>(
                      value: paymentMethod,
                      items: <String>['Google Pay', 'PhonePe', 'Card', 'Wallet']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                value == 'Card'
                                    ? Icons.credit_card
                                    : (value == 'Google Pay'
                                        ? Icons.payment
                                        : (value == 'PhonePe'
                                            ? Icons.mobile_friendly
                                            : Icons.account_balance_wallet)),
                                color: Colors.redAccent,
                              ),
                              SizedBox(width: 10),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          paymentMethod = newValue!;
                          // Generate QR code data based on selected payment method
                          qrData =
                              'Amount: ₹${widget.amount}, Payment Method: $paymentMethod';
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    // Display QR Code
                    if (qrData.isNotEmpty && paymentMethod != 'Card')
                      // Uncomment and use QrImage widget when you have the QR code package
                      // QrImage(
                      //   data: qrData,
                      //   version : QrVersions.auto,
                      //   size: 200.0,
                      // ),
                      SizedBox(height: 20),
                    // Display Payment Method Image
                    if (paymentMethod == 'Google Pay' ||
                        paymentMethod == 'PhonePe')
                      Image.asset(
                        _getPaymentImage(),
                        width: 100.0,
                        height: 100.0,
                      ),
                    // Card Payment Fields
                    if (paymentMethod == 'Card') ...[
                      TextField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: expirationDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiration Date (MM/YY)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                    ],
                    // Button to confirm payment
                    ElevatedButton(
                      onPressed: () {
                        _confirmPayment(context);
                      },
                      child: Text('Confirm Payment'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
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

  void _confirmPayment(BuildContext context) {
    double amountToPay = double.parse(widget.amount);
    double userBalance = double.parse(widget.totalBalance);

    if (paymentMethod == 'Wallet' && userBalance < amountToPay) {
      // Show error if balance is insufficient
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insufficient Balance'),
            content: Text('You do not have enough balance in your wallet.'),
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
      return;
    }

    // Proceed with payment confirmation
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text(
              'You have successfully paid ₹${widget.amount} using $paymentMethod.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the Travel History Page with payment details
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TravelHistoryPage(
                      amount: widget.amount,
                      destination: widget.destination,
                      transportName: '', // Example transport name
                      numberOfMembers: 1, // Example number of members
                      selectedDate: '', // Example date
                      selectedTime: '', // Example time
                      paymentType: '', // Example payment type
                      paymentMethod: paymentMethod, // Pass the payment method
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    // Deduct amount from user wallet if payment method is wallet
    if (paymentMethod == 'Wallet') {
      // Logic to deduct amount from user wallet and add to admin wallet
      // This is where you would implement the backend call to update the wallets
      // For demonstration, we will just show a message
      print(
          'Deducting ₹$amountToPay from user wallet and adding to admin wallet.');
    }
  }
}
