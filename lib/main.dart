import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';
import 'screens/home_screen.dart';
import 'widgets/floating_icons_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rhythm & Waves Fest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.accentPink,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.black),
      ),
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [
          const FloatingIconsBackground(
            density: 22,
            minSize: 12,
            maxSize: 24,
            speed: 10,
            opacity: 0.06,
          ),
          if (child != null) child,
        ],
      ),
      home: const HomeScreen(),
    );
  }
}
