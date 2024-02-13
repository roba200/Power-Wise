import 'package:flutter/material.dart';

class DashBoardCard2 extends StatelessWidget {
  final double value;
  final String title;
  final String symb;
  final Color boxColor;
  const DashBoardCard2(
      {super.key,
      required this.boxColor,
      required this.value,
      required this.title,
      required this.symb});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 8,
      color: boxColor,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 12, bottom: 2),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    value.toString() + '' + symb,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(color: Colors.transparent),
        height: screenWidth * 0.19,
        width: screenWidth * 0.42,
      ),
    );
  }
}
