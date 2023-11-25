import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/map_route1': (context) => MapRoute1Screen(),
        '/map_route2': (context) => MapRoute2Screen(),
        '/pink': (context) => PinkScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Booking'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/map_route1');
          },
          child: Text('Go to Map Route 1'),
        ),
      ),
    );
  }
}

class MapRoute1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Route 1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/map_route2');
          },
          child: Text('Go to Map Route 2'),
        ),
      ),
    );
  }
}

class MapRoute2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Route 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/pink');
          },
          child: Text('Go to Pink Screen'),
        ),
      ),
    );
  }
}

class PinkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pink Screen'),
      ),
      body: Center(
        child: Text('This is the Pink Screen!'),
      ),
    );
  }
}
