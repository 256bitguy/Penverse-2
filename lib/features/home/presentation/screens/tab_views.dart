import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../widgets/event_card.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1E23),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back, User!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard('Posts', '12'),
                  _buildStatCard('Following', '256'),
                  _buildStatCard('Followers', '1.2K'),
                ],
              ),
            ],
          ),
        ),
        const PostCard(
          username: 'John Doe',
          timeAgo: '2h ago',
          content: 'Just published my first blog post about Flutter development! Check it out!',
          likes: 24,
          comments: 8,
          shares: 3,
        ),
        const EventCard(
          title: 'Flutter Meetup',
          date: 'Tomorrow at 6 PM',
          location: 'Tech Hub',
          attendees: 45,
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Card(
        color: const Color(0xFF0D1117),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedTabView extends StatelessWidget {
  const FeedTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        PostCard(
          username: 'Jane Smith',
          timeAgo: '1h ago',
          content: 'Amazing conference today! Learning so much about mobile development.',
          imageUrl: 'https://picsum.photos/500/300',
          likes: 45,
          comments: 12,
          shares: 5,
        ),
        PostCard(
          username: 'Mike Johnson',
          timeAgo: '3h ago',
          content: 'Just launched my new app! Thanks everyone for the support!',
          likes: 89,
          comments: 24,
          shares: 15,
        ),
        PostCard(
          username: 'Sarah Williams',
          timeAgo: '5h ago',
          content: 'Great team meeting today. Excited about our new project!',
          imageUrl: 'https://picsum.photos/500/301',
          likes: 34,
          comments: 8,
          shares: 2,
        ),
      ],
    );
  }
}

class EventsTabView extends StatelessWidget {
  const EventsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        EventCard(
          title: 'Tech Conference 2024',
          date: 'March 15, 2024',
          location: 'Convention Center',
          imageUrl: 'https://picsum.photos/500/302',
          attendees: 120,
        ),
        EventCard(
          title: 'Mobile Dev Meetup',
          date: 'March 20, 2024',
          location: 'Innovation Hub',
          imageUrl: 'https://picsum.photos/500/303',
          attendees: 45,
        ),
        EventCard(
          title: 'Startup Networking',
          date: 'March 25, 2024',
          location: 'Business Center',
          imageUrl: 'https://picsum.photos/500/304',
          attendees: 75,
        ),
      ],
    );
  }
}

class CommunitiesTabView extends StatelessWidget {
  const CommunitiesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCommunityCard(
          'Flutter Developers',
          'A community for Flutter enthusiasts',
          '5.2K members',
          true,
          context,
        ),
        _buildCommunityCard(
          'Tech Entrepreneurs',
          'Connect with fellow startup founders',
          '3.8K members',
          false,
          context,
        ),
        _buildCommunityCard(
          'UI/UX Designers',
          'Share and discuss design ideas',
          '4.1K members',
          false,
          context,
        ),
      ],
    );
  }

  Widget _buildCommunityCard(
    String name,
    String description,
    String members,
    bool isJoined,
    BuildContext context,
  ) {
    return Card(
      color: const Color(0xFF1B1E23),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.group, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        members,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                child:
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isJoined ? Colors.white24 : Theme.of(context).primaryColor,
                  ),
                  child: Text(isJoined ? 'Joined' : 'Join'),
                ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}