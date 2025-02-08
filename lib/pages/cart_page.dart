import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF79AEB2),
      ),
      body: const Center(
        child: Text('Cart Page'),
      ),
    );
  }
}