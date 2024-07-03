import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  int currentPageIndex = 0;

  NavBar({
    super.key,
    required this.currentPageIndex,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    var items = ['/home', '/assignment', '/test', '/task', '/account'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: NavigationBar(
          labelBehavior: labelBehavior,
          selectedIndex: widget.currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              widget.currentPageIndex = index;
              context.go(items[index]);
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.book),
              label: 'Assignments',
            ),
            NavigationDestination(
              icon: Icon(Icons.assignment_rounded),
              label: 'Tests',
            ),
            NavigationDestination(
              icon: Icon(Icons.task_alt_rounded),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Account',
            )
          ],
        ),
      ),
    );
  }
}
