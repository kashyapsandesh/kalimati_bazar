import 'package:flutter/material.dart';
import 'package:kalimati_bazar/constants/color_const.dart';
import 'package:kalimati_bazar/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeChanger.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: onboardingBackground,
        title: const Text("Settings",
            style: TextStyle(color: iconBackgroundColor)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isDarkMode
                      ? const Color.fromARGB(66, 67, 66, 66)
                      : itembackgroundColor,
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                        title: Text("Light Mode"),
                        value: ThemeMode.light,
                        groupValue: themeChanger.themeMode,
                        onChanged: themeChanger.setTheme),
                    RadioListTile<ThemeMode>(
                        title: Text("Dark Mode"),
                        value: ThemeMode.dark,
                        groupValue: themeChanger.themeMode,
                        onChanged: themeChanger.setTheme),
                    RadioListTile<ThemeMode>(
                        title: Text("System Mode"),
                        value: ThemeMode.system,
                        groupValue: themeChanger.themeMode,
                        onChanged: themeChanger.setTheme),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isDarkMode
                        ? const Color.fromARGB(66, 67, 66, 66)
                        : itembackgroundColor,
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.height,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text("About KaliMati Bazar"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Icon(Icons.arrow_right_alt),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
