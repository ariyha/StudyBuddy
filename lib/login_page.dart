import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'dart:developer';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
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
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        await _signInWithGoogle(context);
                      },
                      icon: const Icon(
                        Icons.g_mobiledata,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: Text('Sign in with Google',
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A9D8F),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to email sign in page
                      },
                      icon: const Icon(Icons.email, color: Colors.white),
                      label: Text('Sign in with Email',
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const HomePage();
      },
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      print('\n\n\n\n\n hello \n\n\n\n\n');
      if (user != null) {
        await _checkAndCreateUserCollection(user);
      }
    } catch (e) {
      log(e.toString());
      // Handle sign-in errors here
    }
  }

  Future<void> _checkAndCreateUserCollection(User user) async {
    var db = FirebaseFirestore.instance;
    var userDoc = db.collection('users').doc(user.uid);
    var docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'email': user.email,
        'displayName': user.displayName,
        'groups': [],
        'classes': [],
      });
    }
  }
}

class EmailSignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in with Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _signInWithEmailAndPassword(context);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      context.go('/home');
    } catch (e) {
      print(e);
      // Handle sign-in errors here
    }
  }
}
