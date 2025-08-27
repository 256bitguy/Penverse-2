import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/providers/auth_provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      color: const Color(0xFF1B1E23),
      icon: const CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white24,
        child: Icon(Icons.person_outline, color: Colors.white),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'email',
          enabled: false,
          child: Text(
            authProvider.userEmail ?? 'User',
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person_outline, color: Colors.white70),
              SizedBox(width: 8),
              Text('Profile', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined, color: Colors.white70),
              SizedBox(width: 8),
              Text('Settings', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout_outlined, color: Colors.white70),
              SizedBox(width: 8),
              Text('Logout', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
      onSelected: (String value) async {
        if (value == 'logout') {
          await authProvider.logout();
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
        // Handle other menu items here
      },
    );
  }
}