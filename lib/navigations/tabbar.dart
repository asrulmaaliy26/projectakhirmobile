import 'package:flutter/material.dart';
import 'package:projectakhirmobile/views/home.dart';
import 'package:projectakhirmobile/views/library.dart';
import 'package:projectakhirmobile/views/profile.dart';
import 'package:projectakhirmobile/views/search.dart';

// ignore: use_key_in_widget_constructors
class Tabbar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HomeView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            // ignore: unnecessary_this
            this._selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: "Your Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: Stack(
        children: [
          IgnorePointer(
            child: Opacity(
              opacity: _selectedTab == 0 ? 1 : 0,
              child: HomeView(),
            ),
          ),
          renderView(
            0,
            HomeView(),
          ),
          renderView(
            1,
            SearchView(),
          ),
          renderView(
            2,
            LibraryView(),
          ),
          renderView(
            3,
            ProfileView(),
          ),
        ],
      ),
    );
  }

  Widget renderView(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
