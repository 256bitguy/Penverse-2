import 'package:flutter/material.dart';
import 'package:penverse/core/constants/constants.dart';

class UserProfilePage extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String role; // author, editor, publisher
  final int readers;
  final int purchased;
  final int subscribers;
  final String description;
  final List<String> tags;
  final List<   String> titles; // { title, cover }
  final List<Map<String, String>> works; // { title, cover }

  const UserProfilePage({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.role,
    required this.readers,
    required this.purchased,
    required this.subscribers,
    required this.description,
    required this.tags,
    required this.titles,
    required this.works,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String filter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        foregroundColor: Colors.white70,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStats(),
            const SizedBox(height: 20),
            _buildAboutSection(),
            const SizedBox(height: 20),
            _buildTags(),
            const SizedBox(height: 20),
            _buildFilterBar(),
            const SizedBox(height: 10),
            _buildWorksGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: widget.avatarUrl.isNotEmpty
              ? NetworkImage(widget.avatarUrl)
              : null,
          backgroundColor: Colors.grey.shade200,
          child: widget.avatarUrl.isEmpty
              ? const Icon(Icons.person, size: 50, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.role.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     // Handle subscribe action
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.black,
        //     foregroundColor: Colors.white,
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        //   child: const Text(
        //     "Subscribe",
        //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        //   ),
        // )
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statItem("Readers", widget.readers.toString()),
        _statItem("Purchased", widget.purchased.toString()),
        _statItem("Subscribers", widget.subscribers.toString()),
      ],
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 15, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: widget.tags
          .map((tag) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(tag),
              ))
          .toList(),
    );
  }

  Widget _buildFilterBar() {
    List<String> filters = widget.titles;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.map((item) {
          bool isSelected = filter == item;
          return GestureDetector(
            onTap: () => setState(() => filter = item),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cardBackground
                    : AppColors.cardBackground.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? Colors.white12 : Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWorksGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.works.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final work = widget.works[index];
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://m.media-amazon.com/images/I/81-QB7nDh4L._AC_UY327_FMwebp_QL65_.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              work["title"] ?? "Untitled",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        );
      },
    );
  }
}
