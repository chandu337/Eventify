import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime? _selectedDate;


  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      try {
        final userId = Supabase.instance.client.auth.currentUser?.id;
      await Supabase.instance.client.from('events').insert({
          'title': _titleController.text.trim(),
          'description': _descriptionController.text.trim(),
          'date': _selectedDate!.toIso8601String(),
          'image': _imageController.text.trim(),
          'club': _clubController.text.trim(),
          'location': _locationController.text.trim(),
          'created_by': userId,
        }); 
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Event created successfully")),
          );
          _formKey.currentState!.reset();
          setState(() => _selectedDate = null);
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected Error: $e")),
        );
      }
  } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date")),
      );
  }
}
  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: inputDecoration.copyWith(labelText: 'Title'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: inputDecoration.copyWith(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter description'
                      : null,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: inputDecoration.copyWith(labelText: 'Date'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                              : 'Pick a date',
                          style: TextStyle(
                            color: _selectedDate != null
                                ? Colors.black
                                : Colors.grey.shade600,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: inputDecoration.copyWith(labelText: 'Image URL'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter image URL' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _clubController,
                  decoration: inputDecoration.copyWith(labelText: 'Club'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter club name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: inputDecoration.copyWith(labelText: 'Location'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter location' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed:(){
                    _validateAndSubmit();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Create Event"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
