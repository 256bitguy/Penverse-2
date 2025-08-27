import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  const PostCard({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B1E23),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
            title: Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              timeAgo,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white70),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (imageUrl != null)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildInteractionButton(
                  icon: Icons.favorite_border,
                  count: likes,
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                _buildInteractionButton(
                  icon: Icons.comment_outlined,
                  count: comments,
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                _buildInteractionButton(
                  icon: Icons.share_outlined,
                  count: shares,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required int count,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}