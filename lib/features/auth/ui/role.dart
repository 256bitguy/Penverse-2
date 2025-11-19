import 'package:flutter/material.dart';
import 'package:penverse/core/constants/app_colors.dart';
import 'package:penverse/features/profile/ui/user_profile.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedRole;
  bool _isSubmitting = false;
  final List<String> roles = [
    "Student",
    "Author",
    "Publisher",
    "Editor",
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        title: const Text("Complete Your Profile"),
        centerTitle: true,
        elevation: 0,
      ),

      // ---------------- BOTTOM BUTTON FIXED ----------------
      // put this at the top of your State class

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground.withOpacity(0.4),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isSubmitting
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (selectedRole == null) {
                        setState(() {}); // show “Please select a role”
                        return;
                      }

                      setState(() => _isSubmitting = true);

                      try {
                        final fullName = fullNameController.text.trim();
                        final role = selectedRole;
                        Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UserProfilePage(
      avatarUrl: "https://m.media-amazon.com/images/I/81-QB7nDh4L._SY466_.jpg",
      name: "Vivek Raj",
      role: "Author",
      readers: 1250,
      purchased: 320,
      subscribers: 180,
      description:
          "Author of fiction, self-help and motivational books. Passionate about storytelling.",
      tags: ["Fiction", "Self-help", "Motivation", "Writing"],
      works: [
        {
          "title": "The Rising Dawn",
          "cover": "https://example.com/book1.jpg",
        },
        {
          "title": "Broken Shadows",
          "cover": "https://example.com/book2.jpg",
        },
        {
          "title": "Mindset Mastery",
          "cover": "https://example.com/book3.jpg",
        },{
          "title": "The Rising Dawn",
          "cover": "https://example.com/book1.jpg",
        },
        {
          "title": "Broken Shadows",
          "cover": "https://example.com/book2.jpg",
        },{
          "title": "The Rising Dawn",
          "cover": "https://example.com/book1.jpg",
        },
        {
          "title": "Broken Shadows",
          "cover": "https://example.com/book2.jpg",
        },
        {
          "title": "Mindset Mastery",
          "cover": "https://example.com/book3.jpg",
        },
      ],
      titles: ["All", "Books", "Articles", "Stories", "Poems"],
    ),
  ),
);


                        // ---------- API CALL ----------
                        // final response = await Future.delayed(
                        //   const Duration(seconds: 2),
                        //   // () => ApiResponse(success: true, message: "Profile updated"),
                        // );

                        // if (!mounted) return;

                        // if (response.success) {

                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(response.message),
                        //       backgroundColor: Colors.red,
                        //     ),
                        //   );
                        // }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Something went wrong"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } finally {
                        if (mounted) {
                          setState(() => _isSubmitting = false);
                        }
                      }
                    },
              child: _isSubmitting
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: isDesktop ? 500 : double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------- FULL NAME ----------------
                const Text(
                  "Full Name",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: fullNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your full name",
                    hintStyle: const TextStyle(color: Colors.white60),
                    filled: true,
                    fillColor: AppColors.cardBackground.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Full name is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // ---------------- ROLE SECTION ----------------
                const Text(
                  "Select Your Role",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),

                Column(
                  children: roles.map((role) {
                    final isSelected = selectedRole == role;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.cardBackground.withOpacity(0.4)
                            : AppColors.cardBackground.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: RadioListTile(
                        activeColor: AppColors.primary,
                        title: Text(role,
                            style: const TextStyle(color: Colors.white)),
                        value: role,
                        groupValue: selectedRole,
                        onChanged: (value) {
                          setState(() => selectedRole = value);
                        },
                      ),
                    );
                  }).toList(),
                ),

                if (selectedRole == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 4),
                    child: Text(
                      "Please select a role",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
