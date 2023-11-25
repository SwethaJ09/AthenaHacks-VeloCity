// auth_screen.dart

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Replace this authentication logic with your actual authentication mechanism
  bool _authenticate() {
    // Simulate authentication, you should replace this with real authentication logic
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Example authentication logic (replace this with your authentication logic)
    if (username == 'user' && password == 'password') {
      return true; // Authentication successful
    } else {
      return false; // Authentication failed
    }
  }

  void _login() {
    if (_authenticate()) {
      // Navigate to the home screen upon successful login
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show an error message or handle authentication failure
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Authentication Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
