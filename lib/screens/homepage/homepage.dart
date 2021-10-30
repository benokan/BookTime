import 'package:book_time/screens/explore/explore.dart';
import 'package:book_time/screens/mybooks/mybooks.dart';
import 'package:book_time/screens/profile/profile.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [MyBooksPage(), ExplorePage(), ProfilePage()];
  int _selectedIndex = 1;

  @override // to make Explore Page the first one to be displayed
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp,
                color: _selectedIndex == 0 ? Colors.black87 : Colors.grey[800]),
            label: 'My Books',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_rounded,
                  color:
                      _selectedIndex == 1 ? Colors.black87 : Colors.grey[800]),
              label: 'Explore',
              backgroundColor: Colors.brown),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 2 ? Colors.black87 : Colors.grey[800]),
            label: 'Profile',
            backgroundColor: Colors.brown,
          ),
        ],
        backgroundColor: Colors.brown[200],
        iconSize: 40,
        elevation: 50,
        fixedColor: Colors.grey[800],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
