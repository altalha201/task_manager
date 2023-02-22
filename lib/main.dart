import 'package:flutter/material.dart';
import 'package:task_manager/screens/email_verification_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreen(),
        '/login' : (context) => LoginScreen(),
        '/emailVerification' : (context) => EmailVerificationScreen(),
      },
    );
  }
}
