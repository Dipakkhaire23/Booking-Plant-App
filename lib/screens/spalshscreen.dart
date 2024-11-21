import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../UIscreen/onboarding Sreen.dart';
import 'login.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _startAnimation();
    Timer(Duration(seconds: 4), () {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user != null) {
        Navigator.push(
          context,
          PageTransition(
            child: OnboardingScreen(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    });
  }

  void _startAnimation() {
    setState(() {
      _opacity = 1.0; // Fade in the splash screen
    });
    _controller.forward(); // Start scaling the image
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/kisanimage.jpg', // Replace with your image path
            fit: BoxFit.cover, // Ensure the image covers the screen
            width: double.infinity,
            height: double.infinity,
          ),
          // Semi-transparent white overlay
          Container(
            color: Colors.white.withOpacity(0.8), // Adjust the opacity here
            width: double.infinity,
            height: double.infinity,
          ),
          // Main content
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 2),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                "Welcome to ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', // Using the internal Roboto font
                  fontStyle: FontStyle.italic, // Adding italic style
                ),
              ),


                  Text('Sakshi-Hitech Nursery', style: TextStyle(fontSize: 20,color: Colors.black)),
                  Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(
                          'assets/1000000568-removebg-preview.png',
                          fit: BoxFit.cover,
                          height: 300,
                          width: 300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
