import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/views/screens/home_screen.dart';
import 'package:kalimati_bazar/views/screens/settings_screen.dart';
import 'package:kalimati_bazar/views/screens/table_screen.dart';
import 'package:line_icons/line_icons.dart';

Widget bottomNavBar() {
  List<Widget> pages = [HomeScreen(), TableScreen(), SettingsScreen()];
  return Container(
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
            pages[index];
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
            )
          ]),
    ),
  );
}
