import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  final VoidCallback onSplashComplete;

  const SplashScreen({super.key, required this.onSplashComplete});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
      onSplashComplete(); // Trigger the popup after navigating to the home screen
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to DEEN App',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
