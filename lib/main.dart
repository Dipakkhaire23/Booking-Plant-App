import 'package:flutter/material.dart';
import 'package:food/UIscreen/onboarding%20Sreen.dart';

import 'package:food/firebase_options.dart'; // Import the generated Firebase options

import 'package:firebase_core/firebase_core.dart';

import 'package:food/screens/signup.dart';
import 'package:food/screens/spalshscreen.dart';

import 'UIscreen/homepage.dart';
import 'UIscreen/rootpage.dart';
import 'UIscreen/sacnpage.dart';
import 'UIscreen/speech.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen (), // Your ProfilePage widget
    );
  }
}
