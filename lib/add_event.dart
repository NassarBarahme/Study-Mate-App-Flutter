import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String eventTitle = "";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  static const _primaryColor = Colors.teal;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _courseController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  OutlineInputBorder _defaultBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: _primaryColor, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
        backgroundColor: _primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Event Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Event Title",
                  hintText: "Enter the title of your event",
                  border: _defaultBorder(),
                  focusedBorder: _focusedBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    eventTitle = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Course Name
              TextFormField(
                controller: _courseController,
                decoration: InputDecoration(
                  labelText: "Course Name",
                  hintText: "Enter course name (optional)",
                  border: _defaultBorder(),
                  focusedBorder: _focusedBorder(),
                  prefixIcon: const Icon(Icons.menu_book, color: _primaryColor),
                ),

              ),
              const SizedBox(height: 16),

              // Date picker field
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Event Date",
                  hintText: "Select event date",
                  border: _defaultBorder(),
                  focusedBorder: _focusedBorder(),
                  suffixIcon: const Icon(Icons.calendar_today, color: _primaryColor),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      // small theming so the date picker matches primary color
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(primary: _primaryColor),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      _dateController.text =
                      "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please choose a date";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Time picker field
              TextFormField(
                controller: _timeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Event Time",
                  hintText: "Select event time",
                  border: _defaultBorder(),
                  focusedBorder: _focusedBorder(),
                  suffixIcon: const Icon(Icons.access_time, color: _primaryColor),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          timePickerTheme: TimePickerThemeData(
                            dialHandColor: _primaryColor,
                            hourMinuteTextColor: MaterialStateColor.resolveWith((states) => _primaryColor),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                      _timeController.text =
                      "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please choose a time";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // read values
                      final course = _courseController.text.trim();
                      final date = _dateController.text;
                      final time = _timeController.text;
                      final title = _titleController.text.trim();


                      debugPrint("Saved event: $title | course: $course | date: $date | time: $time");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Event saved successfully!')),
                      );


                      // Navigator.pop(context, { 'title': title, 'course': course, 'date': date, 'time': time });
                    }
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
