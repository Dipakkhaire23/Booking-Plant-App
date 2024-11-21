import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/UIscreen/cardpage.dart';
import 'package:food/UIscreen/fevoritepage.dart';
import 'package:food/UIscreen/homepage.dart';
import 'package:food/UIscreen/profilepage.dart';
import 'package:food/UIscreen/sacnpage.dart';
import 'package:food/screens/signup.dart';
import 'package:page_transition/page_transition.dart';

import '../model/plant.dart';
import '../screens/login.dart';

class rootpage extends StatefulWidget {
  const rootpage({super.key});

  @override
  State<rootpage> createState() => rootpageState();
}

class rootpageState extends State<rootpage> {
  final User user = FirebaseAuth.instance.currentUser!;
 // Get displayName or any other field
  List<Plant> F = [];
  List<Plant> Card = [];
  int bottomNavIndex = 0;

  // Method to get pages
  List<Widget> pages() {
    return [
      HomePage(),
      FavoritePage(favoritedPlants: F),
      CartPage(addedToCartPlants: Card),
      ProfilePage(
          user: user,
          // Pass Name safely (or provide a default fallback)
           // You can pass an actual image here
      ),
    ];
  }
  List<IconData> iconslist = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  List<String> titlel = [
    'Home',
    'Favorite',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titlel[bottomNavIndex],
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
            ),
            Icon(Icons.notifications, color: Colors.black, size: 30)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: bottomNavIndex,
        children: pages(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
        },
        child: Image.asset('assets/scanner logo.png', height: 30),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconslist,
        activeIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
            final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            F = favoritedPlants;
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();
              Card=addedToCartPlants;
            // Update pages here if necessary
            // Update the FavoritePage
          });
        },
        splashColor: Colors.green,
        activeColor: Colors.green,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
      ),
    );
  }
}
