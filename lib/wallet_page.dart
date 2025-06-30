import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double walletBalance = 0.0; // Wallet balance
  List<String> paymentMethods = ['GPay', 'PhonePe', 'Card', 'Bank Transfer'];
  String selectedPaymentMethod = 'GPay'; // Default payment method
  double amountToAdd = 0.0; // Amount to add to wallet

  @override
  void initState() {
    super.initState();
    _loadWalletBalance(); // Load wallet balance from SharedPreferences
  }

  Future<void> _loadWalletBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance = prefs.getDouble('walletBalance') ?? 0.0;
      // Add default bonus if the wallet is empty
      if (walletBalance == 0.0) {
        walletBalance = 100.0; // Default bonus
        prefs.setDouble('walletBalance', walletBalance); // Save the bonus
      }
    });
  }

  void _addMoneyToWallet(double amount) async {
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please enter a valid amount greater than zero.')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletBalance += amount;
    });
    await prefs.setDouble('walletBalance', walletBalance);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ₹${amount.toStringAsFixed(2)} to wallet.')),
    );
  }

  void _transferMoneyToBank(double amount) async {
    if (amount <= walletBalance) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        walletBalance -= amount;
      });
      await prefs.setDouble('walletBalance', walletBalance);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Transferred ₹${amount.toStringAsFixed(2)} to bank.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient balance in wallet.')),
      );
    }
  }

  void _showAddMoneyOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Money to Wallet'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Payment Method:'),
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  items: paymentMethods
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            value == 'Card'
                                ? Icons.credit_card
                                : (value == 'GPay'
                                    ? Icons.payment
                                    : Icons.mobile_friendly),
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
                      selectedPaymentMethod = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter Amount (₹)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    amountToAdd = double.tryParse(value) ?? 0.0;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (amountToAdd <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount.')),
                  );
                  return;
                }

                // Proceed with the selected payment method
                switch (selectedPaymentMethod) {
                  case 'GPay':
                    _showGPayDialog();
                    break;
                  case 'PhonePe':
                    _showPhonePeDialog();
                    break;
                  case 'Card':
                    _showCardDetailsDialog();
                    break;
                  case 'Bank Transfer':
                    _showBankTransferDialog();
                    break;
                }
              },
              child: Text('Proceed '),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showGPayDialog() {
    TextEditingController gpayController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter GPay ID'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: gpayController,
                decoration: InputDecoration(labelText: 'GPay ID'),
              ),
              SizedBox(height: 20),
              Text('Amount to Add: ₹${amountToAdd.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (gpayController.text.isNotEmpty && amountToAdd > 0) {
                  _addMoneyToWallet(amountToAdd);
                  Navigator.of(context)
                      .pop(); // Close the dialog after adding money
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Please enter a valid GPay ID and amount.')),
                  );
                }
              },
              child: Text('Add Money'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showPhonePeDialog() {
    TextEditingController phonePeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter PhonePe ID'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phonePeController,
                decoration: InputDecoration(labelText: 'PhonePe ID'),
              ),
              SizedBox(height: 20),
              Text('Amount to Add: ₹${amountToAdd.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (phonePeController.text.isNotEmpty && amountToAdd > 0) {
                  _addMoneyToWallet(amountToAdd);
                  Navigator.of(context)
                      .pop(); // Close the dialog after adding money
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please enter a valid PhonePe ID and amount.')),
                  );
                }
              },
              child: Text('Add Money'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showCardDetailsDialog() {
    TextEditingController cardNumberController = TextEditingController();
    TextEditingController expiryDateController = TextEditingController();
    TextEditingController cvvController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Card Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cardNumberController,
                  decoration: InputDecoration(labelText: 'Card Number'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: expiryDateController,
                  decoration:
                      InputDecoration(labelText: 'Expiration Date (MM/YY)'),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: cvvController,
                  decoration: InputDecoration(labelText: 'CVV'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Text('Amount to Add: ₹${amountToAdd.toStringAsFixed(2)}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (cardNumberController.text.isNotEmpty &&
                      expiryDateController.text.isNotEmpty &&
                      cvvController.text.isNotEmpty &&
                      amountToAdd > 0) {
                    _addMoneyToWallet(amountToAdd);
                    Navigator.of(context)
                        .pop(); // Close the dialog after adding money
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Please fill in all card details and enter a valid amount.')),
                    );
                  }
                },
                child: Text('Add Money'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  void _showBankTransferDialog() {
    TextEditingController bankAccountController = TextEditingController();
    TextEditingController ifscCodeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Bank Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bankAccountController,
                decoration: InputDecoration(labelText: 'Bank Account Number'),
              ),
              TextField(
                controller: ifscCodeController,
                decoration: InputDecoration(labelText: 'IFSC Code'),
              ),
              SizedBox(height: 20),
              Text('Amount to Add: ₹${amountToAdd.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (bankAccountController.text.isNotEmpty &&
                    ifscCodeController.text.isNotEmpty &&
                    amountToAdd > 0) {
                  _addMoneyToWallet(amountToAdd);
                  Navigator.of(context)
                      .pop(); // Close the dialog after adding money
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please enter valid bank details and amount.')),
                  );
                }
              },
              child: Text('Add Money'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _confirmPayment(double amount) {
    if (amount <= walletBalance) {
      _transferMoneyToBank(amount); // Deduct from wallet
      // Here you can also add logic to add the amount to the admin's wallet
      print('Adding ₹$amount to admin wallet.');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient balance in wallet.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
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
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wallet Balance: ₹${walletBalance.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                onPressed: _showAddMoneyOptions,
                child: Text('Add Money to Wallet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  _confirmPayment(20.0); // Example amount to transfer
                },
                child: Text('Transfer to Bank'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
