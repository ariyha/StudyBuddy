import 'package:flutter/material.dart';
import 'login_page.dart';
import 'themes/theme.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: theme,
      home: LoginPage(),
    );
  }
}
