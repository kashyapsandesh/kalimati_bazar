import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/constants/font_const.dart';
import 'package:kalimati_bazar/constants/string_const.dart';
import 'package:kalimati_bazar/views/screens/main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int pageIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      imagePath: "assets/images/onboard.png",
      backgroundColor: onboardingBackground,
      insideButtonText: "Skip",
      rightButtonText: "Next",
      title: onboarding1Title,
      description: onboarding1Des,
    ),
    OnboardingItem(
      imagePath: "assets/images/dailyprice.png",
      backgroundColor: onboardingBackground,
      insideButtonText: "Skip",
      rightButtonText: "Next",
      title: onboarding2Title,
      description: onboarding2Des,
    ),
    // Add more OnboardingItem instances for additional screens
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your Onboarding Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 125,
                      left: 30,
                      child: Image.asset(onboardingItems[pageIndex].imagePath),
                    ),
                    ClipPath(
                      clipper: CustomShapeClipper(),
                      child: Container(
                        color: onboardingItems[pageIndex].backgroundColor,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 16.0,
                              bottom: 16.0,
                              child: TextButton(
                                onPressed: () {
                                  // Handle button press
                                  navigateToNextScreen();
                                },
                                child: Text(
                                  onboardingItems[pageIndex].insideButtonText,
                                  style: TextStyle(
                                    color: iconBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 16.0,
                              bottom: 16.0,
                              child: TextButton(
                                onPressed: () {
                                  // Handle button press
                                  navigateToNextScreen();
                                },
                                child: Text(
                                  onboardingItems[pageIndex].rightButtonText,
                                  style: TextStyle(
                                    color: iconBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 70.0,
                              bottom: 270.0,
                              child: Text(
                                onboardingItems[pageIndex].title,
                                style: TextStyle(
                                  color: iconBackgroundColor,
                                  fontFamily: montextra,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 50.0,
                              bottom: 230.0,
                              child: Center(
                                child: Text(
                                  onboardingItems[pageIndex].description,
                                  style: TextStyle(
                                    color: iconBackgroundColor,
                                    fontFamily: montmedium,
                                    fontSize: 16,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen() {
    setState(() {
      if (pageIndex < onboardingItems.length - 1) {
        pageIndex++;
      } else {
        // Navigate to the main screen or another screen when onboarding is completed
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      }
    });
  }
}

class OnboardingItem {
  final String imagePath;
  final Color backgroundColor;
  final String insideButtonText;
  final String rightButtonText;
  final String title;
  final String description;

  OnboardingItem({
    required this.imagePath,
    required this.backgroundColor,
    required this.insideButtonText,
    required this.rightButtonText,
    required this.title,
    required this.description,
  });
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Define control points for Bezier curves
    final double bottomLeftX = 0.0;
    final double bottomLeftY = size.height;
    final double bottomRightX = size.width;
    final double bottomRightY = size.height;
    final double control1X = size.width * 0.2;
    final double control1Y = size.height * 0.6;
    final double control2X = size.width * 0.8;
    final double control2Y = size.height * 0.6;
    final double middleX = size.width * 0.5;
    final double middleY = size.height * 0.5;

    path.moveTo(bottomLeftX, bottomLeftY);
    path.lineTo(bottomLeftX, middleY);
    path.cubicTo(
      control1X,
      control1Y,
      control2X,
      control2Y,
      bottomRightX,
      middleY,
    );
    path.lineTo(bottomRightX, bottomRightY);
    path.lineTo(bottomLeftX, bottomLeftY);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
