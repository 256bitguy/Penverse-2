import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final bool isHomePage;
  const CartPage({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Cart Page | isHomePage = $isHomePage",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
