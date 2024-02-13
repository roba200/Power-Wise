import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/pages/devices_page.dart';
import 'package:power_wise/pages/login_or_sign_up_page.dart';
import 'package:power_wise/pages/register_page.dart';
import 'package:power_wise/pages/test_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DevicesPage();
          } else {
            return LoginOrSignUpPage();
          }
        },
      ),
    );
  }
}
