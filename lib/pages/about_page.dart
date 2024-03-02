import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "Welcome to the future of residential electrical safety and management!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  "Our app, part of the IoT-Based Advanced Circuit Breaker System, is designed to bring unparalleled safety, efficiency, and control directly into the hands of homeowners. Leveraging cutting-edge Internet of Things (IoT) technology, our system transforms how you interact with your home's electrical network."),
              SizedBox(height: 10),
              Text(
                "Key Features",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  "Real-Time Monitoring: Keep a close eye on your home's electrical usage with live data. Understand your consumption patterns and identify potential savings without compromising on comfort."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Remote Control: Say goodbye to manual checks and adjustments. With just a few taps, you can remotely operate your circuit breakers, ensuring your home's electrical system is always under your command, no matter where you are."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Customizable Threshold Settings: Our app allows you to set specific current thresholds for each circuit. If the current exceeds your preset limit, the system automatically cuts off power to the circuit, preventing potential hazards and protecting your home."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Instant Alerts: Stay informed with real-time notifications about your electrical system's status. Whether it's an overload alert or a reminder to check on a circuit, our app keeps you updated, so you're always one step ahead."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "User-Friendly Interface:* We believe in simplicity and efficiency. Our app's design ensures you have all the functionalities you need, right at your fingertips, without any complexities."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Security and Privacy:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  "Your safety and privacy are our top priorities. Our system is built with robust security measures to protect your data and ensure seamless, secure operations."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Join Us:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  "Embrace a smarter, safer, and more efficient way to manage your home's electrical system. Our IoT-Based Advanced Circuit Breaker System app is not just a tool; it's a revolution in home automation and safety"),
            ],
          ),
        ),
      ),
    );
  }
}
