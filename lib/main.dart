import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:power_wise/firebase_options.dart';
import 'package:power_wise/pages/login_or_sign_up_page.dart';
import 'package:power_wise/pages/login_page.dart';
import 'package:power_wise/pages/main_page.dart';
import 'package:power_wise/pages/add_device_page.dart';
import 'package:power_wise/pages/register_page.dart';
import 'package:power_wise/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power Wise',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true),
      // home: TestPage()
      home: SplashScreen(),
      // home: MainPage(),
    );
  }
}
