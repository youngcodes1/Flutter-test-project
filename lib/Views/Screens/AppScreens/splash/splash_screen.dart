import 'package:flutter/material.dart';
import 'package:flutter_test_project/Providers/AuthProvider/auth_provider.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<AuthProvider>(context, listen: false).isUserLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Icon(
          Icons.chat,
          size: 70,
        ),
      ),
    );
  }
}
