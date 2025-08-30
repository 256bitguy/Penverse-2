import 'package:flutter/material.dart';

class LearnPractisePage extends StatefulWidget {
  const LearnPractisePage({super.key});
  @override
  State<LearnPractisePage> createState() => _LearnPractisePageState();
}
class _LearnPractisePageState extends  State<LearnPractisePage>{
  @override
  Widget build(BuildContext context) {
  bool done = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Button Example"),
      ),
     body: Align(
  alignment: Alignment.topRight,
  child: TextButton(
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Button Pressed!")),
      );
    },
    child: const Text("Click Me"),
  ),
),

    );
  }
}
