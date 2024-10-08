import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studybuddy/navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  var _tapcount = 0;
  // Dummy user data

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user = snapshot.data;
          String displayName = user?.displayName ?? 'User';
          return Scaffold(
            appBar: AppBar(
              title: const Text('Account'),
              actions: [
                IconButton(
                  icon:
                      const Hero(tag: 'accounticon', child: Icon(Icons.person)),
                  onPressed: () {
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        displayName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        user!.email ?? 'email id',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        user.uid,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const AccountInfoTile(
                      title: 'Role',
                      value: 'admin',
                      icon: Icons.school,
                    ),
                    const AccountInfoTile(
                      title: 'Tasks Completed',
                      value: '15',
                      icon: Icons.task_alt,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement edit profile functionality
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Request for Admin'),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        _signOut(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Hero(
                tag: 'navbar',
                child: NavBar(
                    currentPageIndex: 4)), // Assuming Accounts is the 5th item
          );
        });
  }

  void _handleTap() {
    setState(() {
      _tapcount++;
      if (_tapcount == 5) {
        _tapcount = 0;
        context.go('/rickroll');
      }
    });
  }

  void _showAboutDialog(BuildContext context) {
    Navigator.of(context).push(PopupRoute(
      page: Dialog(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'About Me (The Human Behind the Keyboard)',
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _handleTap,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Hero(
                        tag: 'accounticon',
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nithish "Bug Creator" Ariyha',
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Professional Googler & Stack Overflow Researcher',
                    style: Theme.of(context).primaryTextTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Skills: Turning coffee into code, debugging by talking to rubber ducks, and mastering the art of "It works on my machine!"',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Warning: Approaching this developer with a bug report may result in sudden caffeine intake and mumbled curses.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('GitHub'),
                        onPressed: () =>
                            _launchURL('https://github.com/ariyha'),
                      ),
                      ElevatedButton(
                        child: const Text('LinkedIn'),
                        onPressed: () =>
                            _launchURL('https://linkedin.com/in/nithishariyha'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      context.go('/');
      await FirebaseAuth.instance.signOut();
      // Optionally, you can sign out from Google Sign-In as well
      await GoogleSignIn().signOut();
    } catch (e) {
      print(e);
      // Handle sign-out errors here
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class AccountInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AccountInfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class PopupRoute extends PageRouteBuilder {
  final Widget page;
  PopupRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const begin = 0.0;
            const end = 1.0;
            var curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityAnimation = animation.drive(tween);
            var scaleAnimation = animation.drive(tween);

            return ScaleTransition(
              scale: scaleAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: child,
              ),
            );
          },
          barrierColor: Colors.black54,
          barrierDismissible: true,
          opaque: false,
        );
}
