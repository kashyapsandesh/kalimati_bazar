import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/views/screens/home_screen.dart';
import 'package:kalimati_bazar/views/screens/settings_screen.dart';
import 'package:kalimati_bazar/views/screens/table_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   int pageIndex = 0;
  List<Widget> pages = [HomeScreen(), TableScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: onboardingBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          child: GNav(
            backgroundColor: onboardingBackground,
            color: iconBackgroundColor,
            activeColor: iconBackgroundColor,
            tabBackgroundColor: tabbackgroundColor,
            gap: 8,
            padding: const EdgeInsets.all(8),
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
                print(pageIndex);
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: ' Home',
              ),
              GButton(
                icon: Icons.table_chart,
                text: ' Tables',
              ),
              GButton(
                icon: Icons.settings,
                text: ' Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}