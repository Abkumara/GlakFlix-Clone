import 'dart:async';

import 'package:flutter/material.dart';

import 'package:glak_flix_app/SCREENS/startedpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StartedPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Center(
          child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 4),
              child: Text(
                'Glak Flix',
                style: TextStyle(
                  fontSize: 90,
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                ),
              ))),
    );
  }
}
