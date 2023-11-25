// main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RideBookingScreen(),
    );
  }
}

class RideBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Booking'),
      ),
      body: Center(
        child: RideForm(),
      ),
    );
  }
}

class RideForm extends StatefulWidget {
  @override
  _RideFormState createState() => _RideFormState();
}

class _RideFormState extends State<RideForm> {
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();
  String _selectedVehicle = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Source'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the source';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Destination'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the destination';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              value: _selectedVehicle,
              items: ['Car', 'Auto', 'Bike', 'Pink'].map((vehicle) {
                return DropdownMenuItem(
                  value: vehicle,
                  child: Text(vehicle),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedVehicle = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Choose a Vehicle'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
                print('Source: ${_sourceController.text}');
                print('Destination: ${_destinationController.text}');
                print('Selected Vehicle: $_selectedVehicle');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
