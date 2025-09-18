import 'package:flutter/material.dart';
import 'materials.dart';
import 'calendar.dart';
import 'profile.dart';
import 'add_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "ArefRuqaa",
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          bodyMedium: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ),
      home: const Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const CalendarPage(),
    const MaterialsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Study Mate"),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Materials"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AddEvent()),
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      ),
    );
  }
}

/// === Home Page Content ===
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SizedBox.expand(
                    child: Card(
                      margin: const EdgeInsets.only(top: 20),
                      child: const ListTile(
                        title: Text("Todays",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                        subtitle: Text("2",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox.expand(
                    child: Card(
                      margin: const EdgeInsets.only(top: 20),
                      child: const ListTile(
                        title: Text("Weekly Progress",
                            style: TextStyle(fontSize: 17, color: Colors.lightBlue)),
                        subtitle: Text("60%",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox.expand(
                    child: Card(
                      margin: const EdgeInsets.only(top: 20),
                      child: const ListTile(
                        title: Text("Next Event",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                        subtitle: Text("20/9",
                            style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16, left: 16),
          child: Text("Today's Tasks",
              style: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.storage, color: Colors.white, size: 24),
            ),
            title: const Text("S202", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Data Structures"),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.table_chart, color: Colors.white, size: 24),
            ),
            title: const Text("CS204", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Database Systems"),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16, left: 16),
          child: Text("Upcoming", style: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.router, color: Colors.white, size: 24),
            ),
            title: const Text("CS305", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Computer Networks"),
          ),
        ),
      ],
    );
  }
}
