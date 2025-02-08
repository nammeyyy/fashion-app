import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Apinya'),
        backgroundColor: const Color(0xFF79AEB2),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Outfit of the Day',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Outfit cards will go here
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Lucky color table',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Lucky color table will go here
          ],
        ),
      ),
    );
  }
}