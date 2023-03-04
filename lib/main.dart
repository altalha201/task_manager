import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_new_task.dart';
import 'package:task_manager/screens/email_verification_screen.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/pin_verification_screen.dart';
import 'package:task_manager/screens/set_password_screen.dart';
import 'package:task_manager/screens/sign_up_screen.dart';
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
        '/' : (context) => const SplashScreen(),
        '/login' : (context) => const LoginScreen(),
        '/emailVerification' : (context) => const EmailVerificationScreen(),
        '/pinVerify' : (context) => const PinVerificationScreen(),
        '/setPass' : (context) => const SetPasswordScreen(),
        '/signUp' : (context) => const SignUpScreen(),
        '/home' : (context) => const HomeScreen(),
        '/addTask' : (context) => const AddNewTask(),
      },
    );
  }
}
