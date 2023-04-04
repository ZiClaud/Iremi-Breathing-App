import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/progress_page.dart';
import 'package:iremibreathingapp/pages/user_page.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    ProgressPage(),
    const MainPage(),
    UserPage(),
  ];

  final List<BottomNavigationBarItem> _items = [
    buildBottomNavigationBarItem(Icons.bar_chart, 'Progress'),
    buildBottomNavigationBarItem(Icons.home, 'Home'),
    buildBottomNavigationBarItem(Icons.person, 'Profile'),
  ];

  static BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Iremi')), // TODO: Improve this
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
