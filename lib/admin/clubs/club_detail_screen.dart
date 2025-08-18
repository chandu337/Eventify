import 'package:flutter/material.dart';

class ClubDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> club;

  const ClubDetailsScreen({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club['name']),
        backgroundColor: club['color'],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                club['image'],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(club['icon'], color: club['color'], size: 28),
                const SizedBox(width: 10),
                Text(
                  club['name'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: club['color'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              club['description'],
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
            ),
            const SizedBox(height: 24),
            Text("ABOUT:",style: TextStyle(color: Colors.blueAccent,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 6,),
            Text(club['about'],style: TextStyle(),),
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Will be available in future")),
                  );
                },
                icon: const Icon(Icons.group_add, color: Colors.white),
                label: const Text(
                  "Join Club",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: club['color'],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
