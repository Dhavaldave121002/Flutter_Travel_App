import 'package:flutter/material.dart';
import 'package:flutter_application_1/Contectuspage.dart';
import 'PaymentPage.dart'; // Ensure this path is correct
import 'user.dart';
import 'userprofile.dart'; // Ensure this path is correct
import 'TravelHistoryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController dateController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, dynamic>> internationalDestinations = [
    {
      'name': 'Paris',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.LjsXuuso9sdcMgElme7Y3AHaE8&pid=Api&P=0&h=180',
      'price': '₹ 15,000',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,000',
          'airlineBrands': ['Air France', 'British Airways']
        },
      },
    },
    {
      'name': 'New York',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.0mOuTg21PKAZGrZ45dat0QHaE7&pid=Api&P=0&h=180',
      'price': '₹ 12,000',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Tokyo',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.3TRZ-5k5aVAxNMogBaXWVQHaE7&pid=Api&P=0&h=180',
      'price': '₹ 1,800',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'London',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.CBXJ5TRM4FiyMf7Ca3wb_gHaEK&pid=Api&P=0&h=180',
      'price': '₹ 1,600',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Sydney',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.9vxlA1nfGKra9LvfhXIhQwHaE5&pid=Api&P=0&h=180',
      'price': '₹ 2,000',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Rome',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.F3mOxrgV_Jw2kgZ2gCXzRgHaEK&pid=Api&P=0&h=180',
      'price': '₹ 1,400',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Barcelona',
      'image':
          'https://tse1.mm.bing.net/th?id=OIP.hCgbLNGQXLh1OqZrUVxZfwHaEK&pid=Api&P=0&h=180',
      'price': '₹ 1,300',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Dubai',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.66tXYjiPO6cXk-8XXsoyiQAAAA&pid=Api&P=0&h=180',
      'price': '₹ 1,700',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Singapore',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.X60vl44HyJ3gRwx0ywak-QHaE8&pid=Api&P=0&h=180',
      'price': '₹ 1,550',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
    {
      'name': 'Istanbul',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.CR1MzcfFN3WyR-WnrL8ZRwHaE3&pid=Api&P=0&h=180',
      'price': '₹ 1,350',
      'transportation': {
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['American Airlines', 'Delta'],
        },
      },
    },
  ];

  final List<Map<String, dynamic>> domesticDestinations = [
    {
      'name': 'Mumbai',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.YdZCa-gge4_B9lpFCybqVgHaE8&pid=Api&P=0&h=180',
      'price': '₹ 1,000',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Ahmedabad to Mumbai',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Mumbai',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Pune to Mumbai',
              'departureTimes': ['8:30 AM', '12:30 PM', '4:30 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 500',
          'options': [
            {
              'name': 'Ahmedabad to Mumbai',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
            {
              'name': 'Delhi to Mumbai',
              'departureTimes': ['6:00 AM', '10:00 AM', '4:00 PM']
            },
            {
              'name': 'Pune to Mumbai',
              'departureTimes': ['7:00 AM', '11:00 AM', '3:00 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,000',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Delhi',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP._dpxdJcbfJnyecpAR4h9agHaE9&pid=Api&P=0&h=180',
      'price': '₹ 800',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Delhi',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
            {
              'name': 'Pune to Delhi',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 600',
          'options': [
            {
              'name': 'Mumbai to Delhi',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Pune to Delhi',
              'departureTimes': ['8:30 AM', '12:30 PM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,500',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Bangalore',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.zw65qV5IOVwy9iH4LS3OGQHaDm&pid=Api&P=0&h=180',
      'price': '₹ 1,200',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Bangalore',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Bangalore',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 700',
          'options': [
            {
              'name': 'Mumbai to Bangalore',
              'departureTimes': ['6:00 AM', '10:00 AM', '4:00 PM ']
            },
            {
              'name': 'Delhi to Bangalore',
              'departureTimes': ['7:30 AM', '11:30 AM', '5:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,800',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Kolkata',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.T9tgQdQtMjK7I2gn-FoBAAHaEz&pid=Api&P=0&h=180',
      'price': '₹ 900',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Kolkata',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Kolkata',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 600',
          'options': [
            {
              'name': 'Mumbai to Kolkata',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Kolkata',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,500',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Chennai',
      'image':
          'https://tse4.mm.bing.net/th?id=OIP.PD2aGbphTdNtDzBiYA9QdgHaFj&pid=Api&P=0&h=180',
      'price': '₹ 850',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Chennai',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Chennai',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 500',
          'options': [
            {
              'name': 'Mumbai to Chennai',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Chennai',
              'departureTimes': ['6:00 AM', '10:00 AM', '4:00 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,200',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Hyderabad',
      'image':
          'https://tse1.mm.bing.net/th?id=OIP.dn_P3Ou3XbuXeZ9Tuyt6JQHaEo&pid=Api&P=0&h=180',
      'price': '₹ 1,100',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Hyderabad',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Hyderabad',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 600',
          'options': [
            {
              'name': 'Mumbai to Hyderabad',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Hyderabad',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,500',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Ahmedabad',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.TcwCWTd3sBUozyYuoLDAhQHaEK&pid=Api&P=0&h=180',
      'price': '₹ 950',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Ahmedabad',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Ahmedabad',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 500',
          'options': [
            {
              'name': 'Mumbai to Ahmedabad',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Ahmedabad',
              'departureTimes': ['6:00 AM', '10:00 AM', '4:00 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,000',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Pune',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.jZzPfzpOiGPn3woOg3fB0QHaF5&pid=Api&P=0&h=180',
      'price': '₹ 750',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Pune',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Pune',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 500',
          'options': [
            {
              'name': 'Mumbai to Pune',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Pune',
              'departureTimes': ['6:00 AM', '10:00 AM', '4:00 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,000',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Jaipur',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.70j8MbFqe6fnzzT325ybsAHaE8&pid=Api&P=0&h=180',
      'price': '₹ 1,200',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Jaipur',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Jaipur',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 600',
          'options': [
            {
              'name': 'Mumbai to Jaipur',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Jaipur',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,500',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Goa',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.SyPXkPKG4eRzH5LNfClIQAHaE8&pid=Api&P=0&h=180',
      'price': '₹ 1,500',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Goa',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Goa',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 700',
          'options': [
            {
              'name': 'Mumbai to Goa',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Goa',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 2,000',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Varanasi',
      'image':
          'https://tse2.mm.bing.net/th?id=OIP.IZcKXH9GjJlBcVegD9zirwHaE8&pid=Api&P=0&h=180',
      'price': '₹ 1,000',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Varanasi',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Varanasi',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 600',
          'options': [
            {
              'name': 'Mumbai to Varanasi',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Varanasi',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,500',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
    {
      'name': 'Udaipur',
      'image':
          'https://tse3.mm.bing.net/th?id=OIP.SCxnUKdlhvG4SwM_9gzwEQHaFS&pid=Api&P=0&h=180',
      'price': '₹ 1,300',
      'transportation': {
        'Taxi': {
          'price': '₹ 4,000',
          'carBrands': ['Toyota', 'Honda', 'Ford']
        },
        'Bus': {
          'price': '₹ 1,500',
          'options': [
            {
              'name': 'Mumbai to Udaipur',
              'departureTimes': ['9:00 AM', '1:00 PM', '6:00 PM']
            },
            {
              'name': 'Delhi to Udaipur',
              'departureTimes': ['8:00 AM', '12:00 PM', '5:00 PM']
            },
          ]
        },
        'Train': {
          'price': '₹ 700',
          'options': [
            {
              'name': 'Mumbai to Udaipur',
              'departureTimes': ['7:00 AM', '11:00 AM', '5:00 PM']
            },
            {
              'name': 'Delhi to Udaipur',
              'departureTimes': ['6:30 AM', '10:30 AM', '4:30 PM']
            },
          ]
        },
        'Airplane': {
          'price': '₹ 1,800',
          'airlineBrands': ['Air India', 'IndiGo', 'SpiceJet']
        },
      },
    },
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      setState(() {
        dateController.text =
            formattedDate; // Set the selected date to the TextField
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter international destinations based on search query
    final filteredInternationalDestinations =
        internationalDestinations.where((destination) {
      return destination['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    // Filter domestic destinations based on search query
    final filteredDomesticDestinations =
        domesticDestinations.where((destination) {
      return destination['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.airplane_ticket_rounded),
            SizedBox(width: 8),
            Text('Travel App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(111, 145, 96, 57),
        actions: [
          Container(
            width: 150,
            child: TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Select Date',
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 250,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    username: '',
                    email: '',
                    mobileNumber: '',
                    dob: '',
                    user: User,
                    password: '',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            if (filteredInternationalDestinations.isNotEmpty) ...[
              const Text('International Destinations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: filteredInternationalDestinations.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (dateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a date')),
                        );
                      } else {
                        _showAirlineOptions(
                            context, filteredInternationalDestinations[index]);
                      }
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    filteredInternationalDestinations[index]
                                        ['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    filteredInternationalDestinations[index]
                                        ['name']!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      filteredInternationalDestinations[index]
                                          ['price']!,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    const Text(
                                      '(per person)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 247, 5, 5)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
            if (filteredDomesticDestinations.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Domestic Destinations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: filteredDomesticDestinations.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showTransportationOptions(
                          context, filteredDomesticDestinations[index]);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    filteredDomesticDestinations[index]
                                        ['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    filteredDomesticDestinations[index]
                                        ['name']!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      filteredDomesticDestinations[index]
                                          ['price']!,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    const Text(
                                      '(per person)',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 247, 5, 5)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ContactInfoWidget(),
            ],
          ],
        ),
      ),
    );
  }

  void _showTransportationOptions(
      BuildContext context, Map<String, dynamic> destination) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Transportation for ${destination['name']}'),
          content: SingleChildScrollView(
            child: ListBody(
              children:
                  destination['transportation'].entries.map<Widget>((entry) {
                if (entry.key == 'Taxi') {
                  return ListTile(
                    title: Text('${entry.key} - ${entry.value['price']}'),
                    onTap: () {
                      _showCarBrandOptions(
                          context, entry.value['carBrands'], destination);
                    },
                  );
                } else if (entry.key == 'Bus') {
                  return ListTile(
                    title: Text('${entry.key} - ${entry.value['price']}'),
                    onTap: () {
                      _showBusOptions(
                          context, entry.value['options'], destination);
                    },
                  );
                } else if (entry.key == 'Train') {
                  return ListTile(
                    title: Text('${entry.key} - ${entry.value['price']}'),
                    onTap: () {
                      _showTrainOptions(
                          context, entry.value['options'], destination);
                    },
                  );
                } else if (entry.key == 'Airplane') {
                  return ListTile(
                    title: Text('${entry.key} - ${entry.value['price']}'),
                    onTap: () {
                      _showAirlineOptions(context, destination);
                    },
                  );
                } else {
                  return ListTile(
                    title: Text('${entry.key} - ${entry.value}'),
                    onTap: () {
                      if (dateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a date')),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              destination['name']!,
                              entry.value,
                              destination['image']!,
                              selectedDate: dateController.text,
                              transportName: entry.key,
                              isDomestic: true,
                              passengerName: '',
                              trainTime: '',
                              required: null,
                              onPaymentComplete: (double) {},
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAirlineOptions(
      BuildContext context, Map<String, dynamic> destination) {
    List<String> airlineBrands =
        destination['transportation']['Airplane']['airlineBrands'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Airline'),
          content: SingleChildScrollView(
            child: ListBody(
              children: airlineBrands.map<Widget>((brand) {
                return ListTile(
                  title: Text(brand),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      _showFlightTimeOptions(context, destination, brand);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFlightTimeOptions(
      BuildContext context, Map<String, dynamic> destination, String airline) {
    final List<String> flightTimes = ['10:00 AM', '2:00 PM', '6:00 PM'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Flight Time for $airline'),
          content: SingleChildScrollView(
            child: ListBody(
              children: flightTimes.map<Widget>((time) {
                return ListTile(
                  title: Text(time),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            destination['name']!,
                            destination['transportation']['Airplane']['price'],
                            destination['image']!,
                            selectedDate: dateController.text,
                            transportName: 'Flight - $airline at $time',
                            isDomestic: false,
                            passengerName: '',
                            trainTime: '',
                            required: null,
                            onPaymentComplete: (double) {},
                          ),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTrainOptions(
      BuildContext context,
      List<Map<String, dynamic>> trainOptions,
      Map<String, dynamic> destination) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Train'),
          content: SingleChildScrollView(
            child: ListBody(
              children: trainOptions.map<Widget>((train) {
                return ListTile(
                  title: Text(train['name']),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      _showTrainTimeOptions(context, train['departureTimes'],
                          destination, train['name']);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTrainTimeOptions(BuildContext context, List<String> departureTimes,
      Map<String, dynamic> destination, String trainName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Departure Time for $trainName'),
          content: SingleChildScrollView(
            child: ListBody(
              children: departureTimes.map<Widget>((time) {
                return ListTile(
                  title: Text(time),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            destination['name']!,
                            destination['transportation']['Train']['price'],
                            destination['image']!,
                            selectedDate: dateController.text,
                            transportName: 'Train - $trainName at $time',
                            isDomestic: true,
                            passengerName: '',
                            trainTime: time,
                            required: null,
                            onPaymentComplete: (double) {},
                          ),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBusOptions(BuildContext context,
      List<Map<String, dynamic>> busOptions, Map<String, dynamic> destination) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Bus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: busOptions.map<Widget>((bus) {
                return ListTile(
                  title: Text(bus['name']),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      _showBusTimeOptions(context, bus['departureTimes'],
                          destination, bus['name']);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBusTimeOptions(BuildContext context, List<String> departureTimes,
      Map<String, dynamic> destination, String busName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Departure Time for $busName'),
          content: SingleChildScrollView(
            child: ListBody(
              children: departureTimes.map<Widget>((time) {
                return ListTile(
                  title: Text(time),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            destination['name']!,
                            destination['transportation']['Bus']['price'],
                            destination['image']!,
                            selectedDate: dateController.text,
                            transportName: 'Bus - $busName at $time',
                            isDomestic: true,
                            passengerName: '',
                            trainTime: time,
                            required: null,
                            onPaymentComplete: (double) {},
                          ),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCarBrandOptions(BuildContext context, List<String> carBrands,
      Map<String, dynamic> destination) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Car Brand for Taxi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: carBrands.map<Widget>((brand) {
                return ListTile(
                  title: Text(brand),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      _showTaxiTimeOptions(context, destination, brand);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTaxiTimeOptions(
      BuildContext context, Map<String, dynamic> destination, String carBrand) {
    final List<String> taxiTimes = ['9:00 AM', '1:00 PM', '5:00 PM'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Taxi Time for $carBrand'),
          content: SingleChildScrollView(
            child: ListBody(
              children: taxiTimes.map<Widget>((time) {
                return ListTile(
                  title: Text(time),
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            destination['name']!,
                            destination['transportation']['Taxi']['price'],
                            destination['image']!,
                            selectedDate: dateController.text,
                            transportName: 'Taxi - $carBrand at $time',
                            isDomestic: true,
                            passengerName: '',
                            trainTime: '',
                            required: null,
                            onPaymentComplete: (double) {},
                          ),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    dateController.dispose(); // Dispose of the TextEditingController
    super.dispose(); // Call the superclass's dispose method
  }
}

class ContactInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(72, 253, 2, 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Contact: +91-851-117-2099',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Add your Facebook link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelHistoryPage(
                        amount: '',
                        numberOfMembers: 0,
                        transportName: '',
                        selectedDate: '',
                        selectedTime: '',
                        destination: '',
                        paymentType: '',
                        paymentMethod: '',
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContectUsPage(), // Navigate to Contact Us page
                    ),
                  );
                },
                icon: const Icon(Icons.contact_mail),
                label: const Text('Contact Us'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
