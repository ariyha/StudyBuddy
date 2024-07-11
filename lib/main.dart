import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studybuddy/Themes/theme.dart';
import 'package:studybuddy/account.dart';
import 'package:studybuddy/assignment.dart';
import 'package:studybuddy/firebase_options.dart';
import 'package:studybuddy/home.dart';
import 'package:studybuddy/login_page.dart';
import 'package:studybuddy/roll.dart';
import 'package:studybuddy/task.dart';
import 'package:studybuddy/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPageIndex = 0;

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 0);
          },
        ),
      ),
      GoRoute(
        path: '/rickroll',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: RickRollPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 0);
          },
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 0);
          },
        ),
      ),
      GoRoute(
        path: '/assignment',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AssignmentPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 1);
          },
        ),
      ),
      GoRoute(
        path: '/test',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TestPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 2);
          },
        ),
      ),
      GoRoute(
        path: '/task',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TaskPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 3);
          },
        ),
      ),
      GoRoute(
        path: '/account',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AccountsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _buildTransition(
                context, animation, secondaryAnimation, child, 4);
          },
        ),
      ),
    ],
  );

  Widget _buildTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child, int targetPageIndex) {
    Offset beginOffset;
    if (targetPageIndex > _currentPageIndex) {
      beginOffset = const Offset(1.0, 0.0);
    } else {
      beginOffset = const Offset(-1.0, 0.0); // slide in from the left
    }
    _currentPageIndex = targetPageIndex;
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Flutter Navigation',
      theme: theme,
    );
  }
}
