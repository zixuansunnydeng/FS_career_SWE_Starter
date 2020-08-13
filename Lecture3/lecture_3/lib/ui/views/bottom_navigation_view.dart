import 'package:flutter/material.dart';
import 'package:lecture_3/ui/views/bookings_view.dart';
import 'package:lecture_3/ui/views/home_view.dart';

class BottomNavigationView extends StatefulWidget {
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeView(),
          BookingsView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.red),
            title: Text('Home', style: TextStyle(color: Colors.red)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.red),
              title: Text('Bookings', style: TextStyle(color: Colors.red)))
        ],
      ),
    );
  }
}
