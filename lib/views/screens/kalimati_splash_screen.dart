import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/constants/font_const.dart';
import 'package:kalimati_bazar/views/screens/onboarding_screen.dart';

class KaliMatiSplashScreen extends StatefulWidget {
  const KaliMatiSplashScreen({super.key});

  @override
  State<KaliMatiSplashScreen> createState() => _KaliMatiSplashScreenState();
}

class _KaliMatiSplashScreenState extends State<KaliMatiSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 5 seconds and then navigate to OnboardingScreen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Texture Image
          Image.asset(
            'assets/images/pattern.png', // Replace with your texture image path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Opacity Overlay
          Container(
            color: onboardingBackground
                .withOpacity(0.8), // Adjust opacity as needed
            width: double.infinity,
            height: double.infinity,
          ),
          // Your Splash Screen Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/applogo.png"),
                // Add any widgets or content you want to display on the splash screen
                Text(
                  'KalaMati Bazar',
                  style: TextStyle(
                    fontFamily: montextra,
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add more widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
