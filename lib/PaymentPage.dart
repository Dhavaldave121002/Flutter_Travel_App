import 'package:flutter/material.dart';
import 'QRCodeUser.dart'; // Ensure you have this page created

class PaymentPage extends StatefulWidget {
  final String destinationName;
  final String destinationPrice;
  final String imageUrl;
  final String transportName;
  final String selectedDate;
  final bool isDomestic;
  final String passengerName;
  final String? trainNumber; // Optional parameter
  final String trainTime;
  final Function(double) onPaymentComplete; // Callback to update wallet

  PaymentPage(
    this.destinationName,
    this.destinationPrice,
    this.imageUrl, {
    required this.transportName,
    required this.selectedDate,
    required this.isDomestic,
    required this.passengerName,
    this.trainNumber,
    required this.trainTime,
    required this.onPaymentComplete,
    required required,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int numberOfMembers = 1; // Initialize number of members

  @override
  Widget build(BuildContext context) {
    double pricePerPerson = double.parse(
        widget.destinationPrice.replaceAll('₹', '').replaceAll(',', '').trim());
    double totalPrice = pricePerPerson * numberOfMembers;

    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and Destination Name Section
              DestinationImageSection(
                imageUrl: widget.imageUrl,
                destinationName: widget.destinationName,
              ),
              SizedBox(height: 20),
              // Description Section
              DescriptionSection(
                destinationName: widget.destinationName,
                destinationPrice: widget.destinationPrice,
              ),
              SizedBox(height: 20),
              // Payment Info Section
              PaymentInfoSection(
                destinationName: widget.destinationName,
                destinationPrice:
                    '₹ ${totalPrice.toStringAsFixed(2)}', // Show total price
                selectedDate: widget.selectedDate,
                transportName: widget.isDomestic
                    ? widget.transportName
                    : 'Airplane', // Show transport only for domestic
              ),
              SizedBox(height: 20),
              // Member Count Section
              MemberCountSection(
                numberOfMembers: numberOfMembers,
                onIncrease: () {
                  setState(() {
                    numberOfMembers++;
                  });
                },
                onDecrease: () {
                  if (numberOfMembers > 1) {
                    setState(() {
                      numberOfMembers--;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Minimum member is one')),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              TotalSection(
                destinationPrice:
                    '₹ ${totalPrice.toStringAsFixed(2)}', // Show total price
              ),
              SizedBox(height: 20),
              Text(
                'Selected Date: ${widget.selectedDate}', // Display the selected date
                style: TextStyle(
                    fontSize: screenWidth * 0.04), // Responsive font size
              ),
              if (widget.isDomestic) // Only show transportation for domestic
                Text(
                  'Transportation: ${widget.transportName}', // Display the selected transportation
                  style: TextStyle(
                      fontSize: screenWidth * 0.04), // Responsive font size
                ),
              SizedBox(height: 20),
              PayButton(
                destinationPrice:
                    '₹ ${totalPrice.toStringAsFixed(2)}', // Pass total price
                imageUrl: widget.imageUrl,
                transportName: widget.transportName,
                totalAmount: totalPrice, // Pass total amount for payment
                onPaymentComplete: widget.onPaymentComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinationImageSection extends StatelessWidget {
  final String imageUrl;
  final String destinationName;

  DestinationImageSection(
      {required this.imageUrl, required this.destinationName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            destinationName,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class MemberCountSection extends StatelessWidget {
  final int numberOfMembers;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  MemberCountSection({
    required this.numberOfMembers,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Number of Members: $numberOfMembers',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: onDecrease,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final String destinationName;
  final String destinationPrice;

  DescriptionSection({
    required this.destinationName,
    required this.destinationPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Destination Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'You are about to book a trip to $destinationName for a total price of $destinationPrice. Enjoy your journey and have a great time exploring!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class PaymentInfoSection extends StatelessWidget {
  final String destinationName;
  final String destinationPrice;
  final String selectedDate;
  final String transportName;

  PaymentInfoSection({
    required this.destinationName,
    required this.destinationPrice,
    required this.selectedDate,
    required this.transportName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Destination: $destinationName', style: TextStyle(fontSize: 16)),
          Text('Total Price: $destinationPrice',
              style: TextStyle(fontSize: 16)),
          Text('Selected Date: $selectedDate', style: TextStyle(fontSize: 16)),
          Text('Transportation: $transportName',
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class TotalSection extends StatelessWidget {
  final String destinationPrice;

  TotalSection({required this.destinationPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(destinationPrice,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}

class PayButton extends StatelessWidget {
  final String destinationPrice;
  final String imageUrl;
  final String transportName;
  final double totalAmount; // Total amount to be paid
  final Function(double) onPaymentComplete; // Callback to update wallet

  PayButton({
    required this.destinationPrice,
    required this.imageUrl,
    required this.transportName,
    required this.totalAmount,
    required this.onPaymentComplete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: Color.fromARGB(239, 196, 46, 26),
        ),
        onPressed: () {
          // Navigate to QR Code page with total amount
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeUser(
                amount:
                    totalAmount.toString(), // Pass the total amount as a string
                imageUrl: imageUrl,
                totalBalance: '', destination: '', // Pass image URL if needed
              ),
            ),
          );

          // Call the callback to update the wallet
          onPaymentComplete(totalAmount);
        },
        child: Text('Pay $destinationPrice',
            style: const TextStyle(
                fontSize: 25, color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );
  }
}
