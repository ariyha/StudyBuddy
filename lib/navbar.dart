import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: NavigationBar(
          labelBehavior: labelBehavior,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.commute),
              label: 'Commute',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            )
          ],
        ),
      ),
    );
  }
}
