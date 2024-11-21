import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/login.dart';
import 'package:page_transition/page_transition.dart';
import '../widget/profilewigets.dart';
import 'constant.dart';

class ProfilePage extends StatelessWidget {
final User user;



  ProfilePage({
    Key? key,
    required this.user,


  }) : super(key: key);
  final auth =FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/1000000568-removebg-preview.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 15),
            Center(
              child:   SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Center(
                      child:  Text(
                        'Dipak',
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: Icon(Icons.verified, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
              Text(
                 user.email ?? 'No Email',
                style: TextStyle(
                  color: Constants.blackColor,
                ),
              ),
              const SizedBox(height: 10),
              // Use a fixed height or let the ListView take available space
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                  ),
                  const ProfileWidget(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  const ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                  ),
                  const ProfileWidget(
                    icon: Icons.share,
                    title: 'Share',
                  ),
                  InkWell(
                    onTap: () {
                      auth.signOut().then((Value){
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const Homepage(),
                            type: PageTransitionType.topToBottom,
                          ),
                        );
                      });
                    },
                    child: const ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ProfilePage extends StatelessWidget {
//   final User user;
//
//
//   ProfilePage({
//     Key? key,
//     required this.user,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.popUntil(context, (route) => route.isFirst);
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 50,
//
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "",
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               user.email ?? 'No Email',
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
