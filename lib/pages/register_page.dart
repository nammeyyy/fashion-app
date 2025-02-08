import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66A1A9),
        elevation: 0,
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Username',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle registration
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF66A1A9),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}