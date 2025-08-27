import 'package:Akalpit/features/home/presentation/widgets/vocab_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      backgroundColor: Colors.deepPurple.shade700,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  authProvider.userEmail ?? 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.quiz_outlined, color: Colors.white70),
            title: const Text(
              'Quiz',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
             Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const VocabScreen()),
);

            },
          ),

          ListTile(
            leading: const Icon(Icons.edit_note_outlined, color: Colors.white70),
            title: const Text(
              'Editorials',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              // Add editorials navigation here
            },
          ),

          ListTile(
            leading: const Icon(Icons.book_outlined, color: Colors.white70),
            title: const Text(
              'Stories',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              // Add stories navigation here
            },
          ),

          ListTile(
            leading: const Icon(Icons.category_outlined, color: Colors.white70),
            title: const Text(
              'Miscellaneous',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              // Add miscellaneous navigation here
            },
          ),

          const Divider(
            color: Colors.white24,
            height: 1,
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
