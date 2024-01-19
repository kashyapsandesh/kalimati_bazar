import 'package:flutter/material.dart';
import 'package:kalimati_bazar/provider/theme_provider.dart';
import 'package:kalimati_bazar/views/screens/kalimati_splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Builder(
        builder: (context) {
          final themeChanger = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeChanger.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              // You can customize the text color for light mode here
              textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black),
                bodyText2: TextStyle(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.dark(primary: Colors.black),
              brightness: Brightness.dark,
              // You can customize the text color for dark mode here
              textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white),
              ),
            ),
            home: const KaliMatiSplashScreen(),
          );
        },
      ),
    );
  }
}
