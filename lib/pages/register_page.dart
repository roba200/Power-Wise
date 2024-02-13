import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/custom_button.dart';
import 'package:power_wise/components/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool agreeToTerms = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void signUp() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "name": _nameController.text,
          "email": FirebaseAuth.instance.currentUser!.email,
          "uid": FirebaseAuth.instance.currentUser!.uid,
        });
      } else {
        showErrorMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message);
    }
  }

  void showErrorMessage(String? message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: widget.onTap,
                  ),
                  Text(
                    '   Register as a new user',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 35),
              CustomTextField(
                hintText: 'Username',
                obsecureText: false,
                controller: _nameController,
              ),
              SizedBox(height: 13),
              CustomTextField(
                hintText: 'Email',
                obsecureText: false,
                controller: _emailController,
              ),
              SizedBox(height: 13),
              CustomTextField(
                hintText: 'New Password',
                obsecureText: false,
                controller: _passwordController,
              ),
              SizedBox(height: 13),
              CustomTextField(
                hintText: 'Confirm Password',
                obsecureText: false,
                controller: _confirmPasswordController,
              ),
              SizedBox(height: 40),
              ListTile(
                title: Text('I accept terms and conditions for this app'),
                leading: Checkbox(
                  value: agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeToTerms = value!;
                    });
                  },
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
              SizedBox(
                height: 60,
              ),
              CustomButton(title: 'Proceed', onPressed: signUp)
            ],
          ),
        ),
      ),
    );
  }
}
