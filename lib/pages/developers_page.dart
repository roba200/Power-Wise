import 'package:flutter/material.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Developer Team"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 70,
                    backgroundImage: AssetImage('images/roba.jpg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Pasindu Deemantha",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 70,
                    backgroundImage: AssetImage('images/hasi.jpeg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Hasindu Shehan",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/mahi.jpeg'),
                    maxRadius: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Tharindu Madhushan",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/kithula.jpeg'),
                    maxRadius: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Thusitha Kithuldora",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/yash.jpeg'),
                    maxRadius: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Thisara Yashodha",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
