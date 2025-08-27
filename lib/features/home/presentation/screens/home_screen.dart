import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = const [
    Center(child: Text("Home Page", style: TextStyle(color: Colors.white, fontSize: 20))),
    Center(child: Text("Explore Page", style: TextStyle(color: Colors.white, fontSize: 20))),
    Center(child: Text("Profile Page", style: TextStyle(color: Colors.white, fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1E23),
        centerTitle: true, // centers the title
        title: const Text(
          "Penverse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // drawer icon color
      ),
      drawer: const Drawer(
        child: Center(
          child: Text("Drawer Menu"),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1B1E23),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
