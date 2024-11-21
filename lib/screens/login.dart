import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/UIscreen/onboarding%20Sreen.dart';
import 'package:food/screens/signup.dart';
import 'package:page_transition/page_transition.dart';
import '../UIscreen/rootpage.dart';
import '../database/authentication.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'forgotpass.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  String welcow = "Facebook";
  Map<String, dynamic>? _userdata;
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  // Global key for form state
  final firebaseauth _auth = firebaseauth();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Custom page transition method
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    }
    // You can add more complex validation here
    return null;
  }

  // Validate password
  String? validateInput(String? value, {bool isEmail = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }

    if (isEmail) {
      // Simple email validation
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(
          value)) {
        return 'Please enter a valid email address';
      }
    }

    return null;
  }

// Usage


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green.shade700,
              Colors.white70,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),

            SizedBox(height: 1),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _opacity,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _opacity,
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          // Email Field
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Email or Phone number",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: validateInput,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password Field
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: true, // Hide password text
                              validator: _validateEmail,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Forgot Password Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      _createRoute(ForgotPasswordPage()));
                                },
                                child: Text(
                                  'Forgot password',
                                  style: TextStyle(color: Colors.grey,
                                      decoration: TextDecoration.underline,fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: SignupPage(),
                                          type: PageTransitionType.leftToRight));
                                },child: Text("SignUp",style: TextStyle(color: Colors.blueAccent,decoration: TextDecoration.underline,fontWeight: FontWeight.bold,fontSize: 20),),
                              )
                            ],
                          ),

                          SizedBox(height: 20),
                          // Login Button
                          ScaleTransition(
                            scale: _scale,
                            child: InkWell(
                              onTap: _Signin,
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Colors.green.shade700,
                                      Colors.green.shade700,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Continue with Social Media',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 30),
                          // Social Media Buttons
                          Row(
                            children: [
                              FadeTransition(
                                opacity: _opacity,
                                child: Container(
                                  width: 150,
                                  child: Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        signWithFacebook();
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            welcow,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              FadeTransition(
                                opacity: _opacity,
                                child: Container(
                                  width: 150,
                                  child: Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50),
                                          color: Colors.orange,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Google',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _Signin() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        Fluttertoast.showToast(
            msg: "Login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Navigator.push(
            context,
            PageTransition(
                child: OnboardingScreen(),
                type: PageTransitionType.rightToLeft));
        _passwordController.clear();
        _emailController.clear();
      }
      else {
        Fluttertoast.showToast(
            msg: "Account Not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }


  Future<UserCredential?> signWithFacebook() async {
    try {
      // Start the Facebook login process
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      // Check if the login was successful
      if (loginResult.status == LoginStatus.success) {
        // Retrieve user data
        final userData = await FacebookAuth.instance.getUserData();
        setState(() {
          welcow = userData['email']; // Store user's email
        });

        // Create OAuth credential
        final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );

        // Sign in with Firebase
        return await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      } else {
        print('Login failed: ${loginResult.message}');
        return null; // Return null if login failed
      }
    } catch (e) {
      print('Error during Facebook sign-in: $e');
      return null; // Return null in case of an error
    }
  }
}
