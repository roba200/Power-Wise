import 'package:flutter/material.dart';

class DashBoardCard1 extends StatelessWidget {
  final double power;
  final String sym;
  const DashBoardCard1({super.key, required this.power, required this.sym});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 8,
      color: Color.fromARGB(255, 112, 68, 238),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Power',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(power.toString() + ' ' + sym,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        decoration: BoxDecoration(color: Colors.transparent),
        height: screenWidth * 0.4,
        width: screenWidth * 0.42,
      ),
    );
  }
}
