// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:studybuddy/assignment.dart';
import 'package:studybuddy/home.dart';
import 'login_page.dart';
import 'themes/theme.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Buddy',
      theme: theme,
      home: AssignmentPage(),
    );
  }
}
