import 'package:flutter/material.dart';
import 'package:flutter_eventify/admin/create_events/provider/create_event_provider.dart';
import 'package:flutter_eventify/student/student_event_detail_screen.dart';
import 'package:flutter_eventify/student/student_status/service/student_status_service.dart';
import 'package:flutter_eventify/student/student_status/student_events_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
class StudentHomeScreen extends ConsumerStatefulWidget {
  const StudentHomeScreen({super.key});
  @override
  ConsumerState<StudentHomeScreen> createState() => _StudentHomeScreenState();
}
class _StudentHomeScreenState extends ConsumerState<StudentHomeScreen> {
  late Map<String,dynamic> userData;
  List<String> events=['All','Tech','Sports','Cultural','Music'];
  String selectedCategory = 'All';
  @override
  Widget build(BuildContext context) {
    final eventItemsAsync = ref.watch(createStudentEventItemProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color.fromARGB(255, 91, 43, 234),const Color.fromARGB(255, 125, 90, 238)],begin: Alignment.topLeft,end: Alignment.bottomRight)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container( 
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)
                            ), 
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: const Color.fromARGB(255, 91, 67, 225),  
                              size: 26,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("Eventify",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25,),)
                        ],
                      ),
                      Row(
                        children: [
                          Tooltip(
                            message: 'Search',
                            child: IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("This feature will be available in future")));
                              }, 
                              icon: const Icon(Icons.search),
                              color: Colors.white
                            )
                          ),
                          SizedBox(width: 5,),
                          Tooltip(
                            message: 'My Events',
                            child: IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentEventsScreen()));
                            }, icon: Icon(Icons.calendar_month_rounded),color: Colors.white),
                          ),
                          SizedBox(width: 5,),
                          Tooltip(
                            message: 'profile',
                            child: IconButton(onPressed: () {
                              context.go('/student/profile');
                            }, icon: Icon(Icons.person_sharp),color: Colors.white,),
                          )
                        ]
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Align(alignment: Alignment.topLeft,child: Text("Welcome Guys!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 3,),
                  Align(alignment: Alignment.topLeft,child: Text("Ready to discover events?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),))
                ],
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final category = events[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => selectedCategory = category);
                      },
                      selectedColor: const Color.fromARGB(255, 91, 67, 225),
                      backgroundColor: Colors.grey[300],
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Events",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: eventItemsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(child: Text("No events available"));
                  }
                  final filteredItems = selectedCategory == 'All'
                      ? items
                      : items
                          .where((item) =>
                              item.club.toLowerCase() ==
                              selectedCategory.toLowerCase())
                          .toList();

                  if (filteredItems.isEmpty) {
                    return const Center(child: Text("No events in this category"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentEventDetailScreen(item: item),
                          ),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                                child: Image.network(
                                  item.image,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.club,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color:  const Color.fromARGB(255, 91, 67, 225),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 5),
                                        Text(
                                          DateFormat('yyyy-MM-dd EEEE')
                                              .format(item.date),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await StudentStatusService.markStatus(
                                                  eventId: item.id!,
                                                  status: "Interested",
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Marked as Interested")),);
                                              } catch (e) {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error: $e")),);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Interested",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await StudentStatusService
                                                    .markStatus(
                                                  eventId: item.id!,
                                                  status: "Going",
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Marked as Going")),);
                                              } catch (e) {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error: $e")),);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Going",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (err, _) => Text("Error: $err"),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}