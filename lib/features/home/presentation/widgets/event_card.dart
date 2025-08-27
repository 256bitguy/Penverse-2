import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String? imageUrl;
  final int attendees;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    this.imageUrl,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B1E23),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '$attendees attending',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 100, // You can adjust this width as needed
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Join'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}