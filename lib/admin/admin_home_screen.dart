import 'package:flutter/material.dart';
import 'package:flutter_eventify/admin/create_events/admin_edit.dart';
import 'package:flutter_eventify/admin/create_events/provider/create_event_provider.dart';
import 'package:flutter_eventify/admin/event_details/event_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});
  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}
class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final eventItemsAsync = ref.watch(createEventItemProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.deepPurpleAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.event_available_rounded,color: Colors.white,),
                            SizedBox(width: 5,),
                            Column(
                              children: [
                                Align(alignment: Alignment.bottomLeft,child: Text("Eventify",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                SizedBox(height: 6,),
                                Text("Admin's Dashboard",style: TextStyle(color: Colors.white,fontSize: 13),),
                              ],
                            ),
                          ]
                        ),
                        Row(
                          children: [
                            Icon(Icons.notifications_none_rounded,color: Colors.white,),
                            SizedBox(width: 5,),
                            IconButton(onPressed: () {
                              context.go('/admin/profile');
                            }, icon: Icon(Icons.person,color: Colors.white,),)
                          ],
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 166, 140, 239),
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      width: double.infinity,                      
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Align(alignment: Alignment.topLeft,child:Text("Welcome back,",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                            SizedBox(height: 8.0,),
                            Align(alignment: Alignment.topLeft,child: Text("Tech Society",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                            SizedBox(height: 8.0,),
                            Align(alignment: Alignment.topLeft,child: Text("Manage your Events",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                            SizedBox(height: 8.0,)
                          ],
                        ),
                      ),
                    ), 
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 145, 75, 174),
                      borderRadius: BorderRadius.circular(15),
                    ),               
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Icon(Icons.menu_book),
                        SizedBox(height: 10.0,),
                        Text("My Events",style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  TextButton(
                    onPressed: ()=>context.go('/admin/createEvent'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 99, 178, 243),
                        borderRadius: BorderRadius.circular(15),
                      ), 
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Icon(Icons.add,color: Colors.white,),
                          SizedBox(height: 6.0,),
                          Text("Create Event",style: TextStyle(color: Colors.white,fontSize: 18),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(alignment:Alignment.topLeft,child:  Text("Your Events",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),)),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
              child: eventItemsAsync.when(
                data: (items){
                  print(items);
                  if(items.isEmpty){
                    return Text("No events available");
                  }
                  return ListView.builder(  
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context,index){
                      final item = items[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailScreen(item: item)));
                        },
                        
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: [
                                ClipRect(child: Image.network(item.image)),
                                SizedBox(height: 7,),
                                Text(item.title,style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 7,),
                                Row(
                                  children: [
                                    Icon(Icons.date_range_rounded),
                                    SizedBox(width: 4,),
                                    Text(DateFormat('yyyy-MM-dd EEEE').format(item.date)),
                                  ],
                                ),
                                SizedBox(height: 7,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 3,),
                                    Text(item.location),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminEditScreen(item: item),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor:Colors.deepPurpleAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                      child:Text("Edit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(width: 5,),
                                    ElevatedButton(onPressed:()async {
                                      await ref.read(createEventItemProvider.notifier).deleteEvent(item.id!);
  
                                    },
                                      
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                      
                                      child:Text("Delete", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),  
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                },
                error: (err,_)=>Text("Error:$err"), 
                loading: ()=>Center(child: CircularProgressIndicator(),))
            )
          ],
        ),
      ),
    );
  }
}