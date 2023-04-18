import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/progress_page.dart';
import 'package:iremibreathingapp/pages/user_page.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../utils/default_widgets.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  int? currentIndex;

  HomePage({Key? key, this.currentIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const ProgressPage(),
    const MainPage(),
    const UserPage(),
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
  void initState() {
    super.initState();

    if (widget.currentIndex != null) {
      _currentIndex = widget.currentIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: myBluLightDark(),
        backgroundColor: myWhiteBlackOpposite(),
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      endDrawer: defaultDrawer(context),
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

  Future<void> _pullRefresh() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(currentIndex: _currentIndex),
      ),
    );
  }
}
