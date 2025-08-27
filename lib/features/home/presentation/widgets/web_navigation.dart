import 'package:flutter/material.dart';

class WebNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const WebNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: true,
      backgroundColor: const Color(0xFF1B1E23),
      labelType: NavigationRailLabelType.none,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.home, color: Colors.white),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.dynamic_feed_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.dynamic_feed, color: Colors.white),
          label: Text('Feed'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.event_outlined, color: Colors.white70),
          selectedIcon: Icon(Icons.event, color: Colors.white),
          label: Text('Events'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people_outline, color: Colors.white70),
          selectedIcon: Icon(Icons.people, color: Colors.white),
          label: Text('Communities'),
        ),
      ],
    );
  }
}