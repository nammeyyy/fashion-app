import 'package:flutter/material.dart';
class PurchaseHistoryPage extends StatelessWidget {

  const PurchaseHistoryPage({super.key});

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Purchase History'),

        backgroundColor: const Color(0xFF79AEB2),

      ),

      body: Center(

        child: const Text(

          'No purchase history available.',

          style: TextStyle(fontSize: 18, color: Colors.black54),

        ),

      ),

    );

  }

}
