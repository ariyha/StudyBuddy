import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).primaryTextTheme.displayLarge,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Handle Google sign in
                },
                icon: Icon(
                  Icons.g_mobiledata,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text('Sign in with Google',
                    style: Theme.of(context).primaryTextTheme.titleMedium),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2A9D8F),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Handle Email sign in
                },
                icon: Icon(Icons.email, color: Colors.white),
                label: Text('Sign in with Email',
                    style: Theme.of(context).primaryTextTheme.titleMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
