import 'package:flutter/material.dart';

class EmptyGreyCard extends StatelessWidget {
  final double CardHeight;
  final Widget? child;
  const EmptyGreyCard(
      {super.key, required this.child, required this.CardHeight});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Card(
        color: Color.fromARGB(255, 252, 252, 252),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: CardHeight,
            width: screenWidth,
            color: Colors.transparent,
            child: child,
          ),
        ));
  }
}
