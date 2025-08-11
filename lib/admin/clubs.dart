import 'package:flutter/material.dart';
class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});
  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}
class _ClubsScreenState extends State<ClubsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> clubs = [
      {
        'name': 'Music Club',
        'icon': Icons.music_note,
        'description': 'Explore your passion for rhythm and melody with our music club.',
        'color': Colors.pinkAccent,
        'image': 'https://i.ytimg.com/vi/btv1MvqD9AM/maxresdefault.jpg'
      },
      {
        'name': 'Tech Club',
        'icon': Icons.computer,
        'description': 'A hub for coders, designers, and tech enthusiasts.',
        'color': Colors.blueAccent,
        'image': 'https://images.unsplash.com/photo-1511376777868-611b54f68947'
      },
      {
        'name': 'Sports Club',
        'icon': Icons.sports_soccer,
        'description': 'Join to compete, stay fit, and celebrate athleticism.',
        'color': Colors.green,
        'image': 'https://t3.ftcdn.net/jpg/07/07/61/40/360_F_707614083_bdideeFZ4Mm3azikIT03XOfyO6d39t0X.jpg'
      },
      {
        'name': 'Cultural Club',
        'icon': Icons.theater_comedy,
        'description': 'Experience art, drama, dance, and diverse cultures.',
        'color': Colors.orange,
        'image': 'https://www.shutterstock.com/image-vector/india-has-incredible-culture-diversity-600w-2237822423.jpg'
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 84, 18, 197),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 84, 18, 197),
                Color.fromARGB(255, 144, 115, 224)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Container(
          child: Row(
            children: [
              SizedBox(width: 7,),
              Container(
                width: 40,
                height: 40,
                child: Icon(Icons.data_thresholding_rounded),
                decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              SizedBox(width: 5,),
              Text("Eventify",style: TextStyle(color: Colors.white,fontSize: 16),)
            ],
           ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: clubs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final club = clubs[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      club['image'],
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image, size: 40)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(club['icon'], color: club['color'], size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          club['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: club['color'],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      club['description'],
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Viewing ${club['name']}")),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                      label: const Text("Explore Club", style: TextStyle(fontSize: 12, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: club['color'],
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}