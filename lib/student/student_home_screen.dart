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
  List<String> events=['Today','Tech','Sports','Cultural','Music'];
  @override
  Widget build(BuildContext context) {
    final EventItemsAsync = ref.watch(createStudentEventItemProvider);
    print(EventItemsAsync);
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
                          Tooltip(message: 'Search',child: IconButton(onPressed: () {}, icon: Icon(Icons.search),color: Colors.white)),
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
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom(                      
                      padding: EdgeInsets.all(14),
                      backgroundColor: const Color.fromARGB(255, 217, 214, 214),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: Text(events[index], style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
                ); 
              }),
            ),
              SizedBox(height: 23,),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(alignment: Alignment.topLeft,
                  child: Text("Upcoming Events",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 21),)
                )
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: EventItemsAsync.when(
                  data: (items){
                    if(items.isEmpty){
                      return Center(child: Text("Empty"),);
                    }
                    return ListView.builder(
                      shrinkWrap: true, 
                      itemCount: items.length,
                      itemBuilder: (context,index){
                      final item = items[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentEventDetailScreen(item: item))),
                        child: Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(item.image),
                                SizedBox(height:7,),
                                Align(alignment: Alignment.topLeft,child: Text(item.club,style: TextStyle(color: Colors.white,fontSize: 17),)),
                                SizedBox(height: 10,),
                                Align(alignment: Alignment.topLeft,child: Text(item.title,style: TextStyle(fontSize: 17),)),
                                SizedBox(height: 7,),
                                Align(alignment: Alignment.topLeft,child: Text(DateFormat('yyyy-MM-dd EEEE').format(item.date),style: TextStyle(fontSize: 16),)),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async{
                                        try {
                                          await StudentStatusService.markStatus(
                                            eventId: item.id!,
                                            status: "Interested",
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Marked as Interested")),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Error: $e")),
                                          );
                                        }
                                      }, 
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                                      child: Text("Interested",style: TextStyle(color: Colors.white),)),
                                    SizedBox(width: 5,),
                                    ElevatedButton(
                                      onPressed: () async{
                                        try {
                                          await StudentStatusService.markStatus(
                                            eventId: item.id!,
                                            status: "Going",
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Marked as Going")),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Error: $e")),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                      child: Text("Going",style: TextStyle(color: Colors.white),))
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }, 
              error: (err,_)=>Text("Err:$err"), 
              loading: ()=>Center(child: CircularProgressIndicator(),)),
            )
          ],
        ),
      ),
    );
  }
}