import 'package:flutter/material.dart';
import 'package:food/UIscreen/rootpage.dart';

import '../screens/login.dart';
import 'constant.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with transparency
          Opacity(
            opacity: 0.5, // Adjust the opacity for desired transparency
            child: Image.asset(
              'assets/1000000568-removebg-preview.png', // Update with your background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Main content
          Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                backgroundColor: Colors.transparent, // Make the AppBar transparent
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => const rootpage()));
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(
                      onPageChanged: (int page) {
                        setState(() {
                          currentIndex = page;
                        });
                      },
                      controller: _pageController,
                      children: [
                        createPage(
                          image: 'assets/germination.png',
                          title: Constants.titleOne,
                          description: Constants.descriptionOne,
                        ),
                        createPage(
                          image: 'assets/germinatin2.png',
                          title: Constants.titleTwo,
                          description: Constants.descriptionTwo,
                        ),
                        createPage(
                          image: 'assets/germination2.png',
                          title: Constants.titleThree,
                          description: Constants.descriptionThree,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 80,
                      left: 30,
                      child: Row(
                        children: _buildIndicator(),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 30,
                      child: Container(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentIndex < 2) {
                                currentIndex++;
                                if (currentIndex < 3) {
                                  _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                }
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const rootpage()));
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  //Extra Widgets

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Container(
           height: 200,
           width: 300,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
           ),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10),
             child: Image.asset(image,fit: BoxFit.cover,),
           ),
         ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
