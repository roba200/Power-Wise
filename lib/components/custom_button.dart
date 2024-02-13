import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const CustomButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
            child: Text(
          title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color.fromARGB(255, 112, 65, 238),
        ),
        height: 58,
        width: screenWidth,
      ),
    );
  }
}
