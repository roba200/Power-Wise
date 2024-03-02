import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/pages/about_page.dart';
import 'package:power_wise/pages/developers_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Sign Out?"),
                    content: Text("Are you sure want to Sign Out?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .signOut()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Text("Yes")),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DevelopersPage()),
              );
            },
            title: Text("Developers"),
          )
        ],
      ),
    );
  }
}
