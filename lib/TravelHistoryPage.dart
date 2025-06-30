import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Import dart:io for file operations

class TravelHistoryPage extends StatefulWidget {
  final String amount; // Amount paid
  final String destination; // Destination name
  final int? numberOfMembers; // Number of members
  final String transportName; // Name of the transportation
  final String selectedDate; // Selected date
  final String selectedTime; // Selected time

  TravelHistoryPage({
    required this.amount,
    required this.destination,
    this.numberOfMembers, // Make this optional
    required this.transportName,
    required this.selectedDate, // Add selected date
    required this.selectedTime,
    required String paymentType,
    required String paymentMethod, // Add selected time
  });

  @override
  _TravelHistoryPageState createState() => _TravelHistoryPageState();
}

class _TravelHistoryPageState extends State<TravelHistoryPage> {
  bool _isCancelled = false; // Track if the trip is cancelled

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel History'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isCancelled
            ? Center(child: Text('Trip has been cancelled.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination Name
                  Text(
                    widget.destination,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Payment Details Section
                  Text(
                    'Payment Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _buildDetailRow(
                      Icons.money, 'Amount Paid: ₹${widget.amount}'),
                  _buildDetailRow(Icons.group,
                      'Number of Members: ${widget.numberOfMembers ?? 1}'), // Default to 1 if null
                  _buildDetailRow(Icons.directions_bus,
                      'Transportation: ${widget.transportName}'),
                  _buildDetailRow(Icons.calendar_today,
                      'Selected Date: ${widget.selectedDate}'),
                  _buildDetailRow(Icons.access_time,
                      'Selected Time: ${widget.selectedTime}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _cancelTrip(context);
                    },
                    child: Text('Cancel Trip'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _downloadTicket(context);
                    },
                    child: Text('Download Ticket'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Go back to the previous page
                    },
                    child: Text('Back to Home'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.black54),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  void _cancelTrip(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cancel Trip'),
          content: Text('Are you sure you want to cancel this trip?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isCancelled =
                      true; // Update state to indicate trip is cancelled
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Trip cancelled successfully!')),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _downloadTicket(BuildContext context) async {
    try {
      // Create the content for the text file
      String content = '''
      Trip Details:
      --------------------
      Destination: ${widget.destination}
      Amount Paid: ₹${widget.amount}
      Number of Members: ${widget.numberOfMembers ?? 1}
      Transportation: ${widget.transportName}
      Selected Date: ${widget.selectedDate}
      Selected Time: ${widget.selectedTime}
      ''';

      // Get the directory to save the file
      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/trip_details.txt';

      // Create and write to the text file
      File file = File(filePath);
      await file.writeAsString(content);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket downloaded successfully to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading ticket: $e')),
      );
    }
  }
}
