import 'package:flutter/material.dart';
import 'package:flutter_eventify/admin/clubs/club_detail_screen.dart';

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
        'about' : 'The Music Club is the heart of rhythm and melody on campus, bringing together singers, instrumentalists, and music enthusiasts. It provides a platform for students to explore different genres of music, collaborate in jam sessions, and showcase their talent in events and competitions. Whether you’re passionate about classical, rock, or contemporary beats, the club helps nurture creativity while spreading the joy of music across the college community.',
        'color': Colors.pinkAccent,
        'image': 'https://i.ytimg.com/vi/btv1MvqD9AM/maxresdefault.jpg'
      },
      {
        'name': 'Tech Club',
        'icon': Icons.computer,
        'description': 'A hub for coders, designers, and tech enthusiasts.',
        'about' : 'The Tech Club is a hub for innovation, coding, and technological exploration. It connects students who are passionate about programming, app and web development, robotics, and cutting-edge fields like AI and cybersecurity. Through workshops, hackathons, and knowledge-sharing sessions, members not only sharpen their technical skills but also work on real-world projects. The club’s mission is to inspire innovation and prepare students for future opportunities in the tech industry.',
        'color': Colors.blueAccent,
        'image': 'https://images.unsplash.com/photo-1511376777868-611b54f68947'
      },
      {
        'name': 'Sports Club',
        'icon': Icons.sports_soccer,
        'description': 'Join to compete, stay fit, and celebrate athleticism.',
        'about':'The Sports Club is dedicated to promoting fitness, teamwork, and a spirit of healthy competition. It offers opportunities for students to participate in a wide range of sports such as football, cricket, basketball, athletics, and indoor games. The club organizes tournaments, training sessions, and fitness programs that help students stay active while developing discipline and leadership skills. It’s the perfect place for anyone who enjoys sports, whether for competition or recreation.',
        'color': Colors.green,
        'image': 'https://t3.ftcdn.net/jpg/07/07/61/40/360_F_707614083_bdideeFZ4Mm3azikIT03XOfyO6d39t0X.jpg'
      },
      {
        'name': 'Cultural Club',
        'icon': Icons.theater_comedy,
        'description': 'Experience art, drama, dance, and diverse cultures.',
        'about': 'The Cultural Club is a celebration of diversity, creativity, and artistic expression. It serves as a stage for students to showcase their talents in drama, dance, art, literature, and traditional performances. From organizing cultural festivals to hosting workshops and competitions, the club fosters unity and encourages appreciation of different cultures. It plays a key role in building confidence, creativity, and teamwork among its members.',
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
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              
              child: Image.asset(
                "assets/eventify.png",
                height: 47,
                width: 47,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Eventify",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Tooltip(
            message: "Search",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          Tooltip(
            message: "My Events",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month, color: Colors.white),
            ),
          ),
          Tooltip(
            message: "Profile",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
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
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      club['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image, size: 40)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(club['icon'], color: club['color'], size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          club['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: club['color'],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    club['description'],
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ClubDetailsScreen(club: club)));
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
      ),
    );
  }
}