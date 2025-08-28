import 'package:flutter/material.dart';

class SavePage extends StatelessWidget {
  final bool isHomePage;
  const SavePage({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Save Page | isHomePage = $isHomePage",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
