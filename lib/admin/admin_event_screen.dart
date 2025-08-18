import 'package:flutter/material.dart';
import 'package:flutter_eventify/admin/create_events/admin_edit.dart';
import 'package:flutter_eventify/admin/create_events/provider/create_event_provider.dart';
import 'package:flutter_eventify/admin/event_details/event_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminEventScreen extends ConsumerStatefulWidget {
  const AdminEventScreen({super.key});

  @override
  ConsumerState<AdminEventScreen> createState() => _AdminEventScreenState();
}

class _AdminEventScreenState extends ConsumerState<AdminEventScreen> {
  @override
  
  Widget build(BuildContext context) {
    final eventItemsAsync = ref.watch(createEventItemProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text("My Events"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
              child: eventItemsAsync.when(
                data: (items){
                  if(items.isEmpty){
                    return Text("No events available");
                  }
                  return ListView.builder(  
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context,index){
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailScreen(item: item),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    item.image,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Colors.purpleAccent,borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      item.club,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.date_range_rounded, size: 18, color: Colors.deepPurple),
                                    const SizedBox(width: 6),
                                    Text(
                                      DateFormat('yyyy-MM-dd EEEE').format(item.date),
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.location,
                                      maxLines: 1,
                                      
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => AdminEditScreen(item: item),),);
                                        },
                                        icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                                        label: const Text(
                                          "Edit",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          await ref.read(createEventItemProvider.notifier).deleteEvent(item.id!);
                                        },
                                        icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                                        label: const Text(
                                          "Delete",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
            ),
    );
  }
}