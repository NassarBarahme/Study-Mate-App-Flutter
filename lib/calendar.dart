import 'package:flutter/material.dart';



class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  // Example events — you can modify or load them from a database later
  final Map<String, List<String>> _events = {
    _keyForDate(DateTime.now()): ['Exam: Data Structures', 'Team Meeting'],
    _keyForDate(DateTime.now().add(const Duration(days: 3))): ['Project Deadline'],
  };

  static String _keyForDate(DateTime d) => '${d.year}-${d.month}-${d.day}';

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekdayNames = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  int _daysInMonth(DateTime month) {
    final nextMonth = DateTime(month.year, month.month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).day;
  }

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final int daysInMonth = _daysInMonth(_focusedMonth);
    final int startWeekday = firstOfMonth.weekday % 7; // Sunday -> 0

    final today = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header — month + navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _prevMonth,
                    icon: const Icon(Icons.chevron_left, size: 28, color: Colors.teal),
                  ),
                  Expanded(
                    child: Text(
                      '${_monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(Icons.chevron_right, size: 28, color: Colors.teal),
                  ),
                ],
              ),
            ),

            // Weekday headers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _weekdayNames
                    .map((w) => Expanded(
                  child: Center(
                    child: Text(
                      w,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),

            const SizedBox(height: 8),

            // Days grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: startWeekday + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < startWeekday) {
                      return const SizedBox();
                    }

                    final day = index - startWeekday + 1;
                    final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
                    final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
                    final isSelected = _selectedDate != null &&
                        date.year == _selectedDate!.year &&
                        date.month == _selectedDate!.month &&
                        date.day == _selectedDate!.day;

                    final hasEvents = _events.containsKey(_keyForDate(date));

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                        });

                        final events = _events[_keyForDate(date)];
                        if (events != null && events.isNotEmpty) {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            context: context,
                            builder: (_) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_monthNames[date.month - 1]} ${date.day}, ${date.year}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(height: 12),
                                  ...events.map((e) => ListTile(
                                    dense: true,
                                    leading: const Icon(Icons.event_note, color: Colors.teal),
                                    title: Text(e),
                                  )),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.teal.withOpacity(0.15) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: isToday
                              ? Border.all(color: Colors.teal, width: 1.8)
                              : Border.all(color: Colors.grey.shade300),
                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.12),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ]
                              : [],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                '$day',
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  fontSize: 15,
                                  color: isSelected ? Colors.teal.shade900 : Colors.black87,
                                ),
                              ),
                            ),
                            if (hasEvents)
                              Positioned(
                                bottom: 6,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Colors.deepOrange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Footer: show selected date and number of events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : '${_monthNames[_selectedDate!.month - 1]} ${_selectedDate!.day}, ${_selectedDate!.year}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _selectedDate == null
                              ? ''
                              : '${_events[_keyForDate(_selectedDate!)]?.length ?? 0} events',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _focusedMonth = DateTime.now();
                              _selectedDate = null;
                            });
                          },
                          child: const Text('Today'),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
