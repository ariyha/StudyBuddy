import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studybuddy/Themes/theme.dart';
import 'package:studybuddy/assignment.dart';
import 'package:studybuddy/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/assignment",
        builder: (context, state) => const AssignmentPage(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Navigation',
      theme: theme,
    );
  }
}
