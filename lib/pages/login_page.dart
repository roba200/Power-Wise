import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/custom_button.dart';
import 'package:power_wise/components/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isChecked = false;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorMessage(String? message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "Sign in",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Text(
                    "Insert Your Log in Details",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                      hintText: "Enter Your Email",
                      obsecureText: false,
                      controller: _emailController),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      hintText: "Enter Your Password",
                      obsecureText: true,
                      controller: _passwordController),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    title: "Log In",
                    onPressed: () async {
                      await signIn();
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "If You are a New User",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 112, 65, 238),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
