import 'package:evchargingpoint/view/screen/user/discover_page.dart';
import 'package:evchargingpoint/view/screen/user/home_page.dart';
import 'package:evchargingpoint/view/screen/user/profile.dart';
import 'package:evchargingpoint/view/screen/user/transaksi_list.dart';
import 'package:flutter/material.dart';

class BottomNavigatorUser extends StatefulWidget {
  const BottomNavigatorUser({super.key});

  @override
  State<BottomNavigatorUser> createState() => _BottomNavigatorUserState();
}

class _BottomNavigatorUserState extends State<BottomNavigatorUser> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const DiscoverPage(),
    const TransaksiPage(),
    const ProfileMenu()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      // _pages[_currentPageIndex],
      IndexedStack(
      index: _currentPageIndex,
      children: _pages,
    ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Discover'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Transaksi'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[600],
        ),
      ),
    );
  }
}


  


