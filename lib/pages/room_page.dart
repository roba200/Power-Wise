import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/dashboard_card_1.dart';
import 'package:power_wise/components/dashboard_card_2.dart';
import 'package:power_wise/components/device_card.dart';
import 'package:power_wise/components/empty_grey_card.dart';
import 'package:power_wise/components/rooms_card.dart';

class RoomPage extends StatefulWidget {
  final String roomNumber;
  final String deviceId;
  final String roomId;
  const RoomPage({
    super.key,
    required this.deviceId,
    required this.roomId,
    required this.roomNumber,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String power = "0";
  String voltage = "0";
  String current = "0";
  String energy = "0";
  bool _lights = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceId}/${widget.roomId}_power")
        .onValue
        .listen((event) {
      setState(() {
        power = event.snapshot.value.toString();
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceId}/voltage")
        .onValue
        .listen((event) {
      setState(() {
        voltage = event.snapshot.value.toString();
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceId}/${widget.roomId}_current")
        .onValue
        .listen((event) {
      setState(() {
        current = event.snapshot.value.toString();
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceId}/${widget.roomId}_energy")
        .onValue
        .listen((event) {
      setState(() {
        energy = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String date = "3rd January 2024";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi,",
                    style: TextStyle(fontSize: 20),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!['name'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text(
                            "Loading...",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          );
                        }
                      }),
                ],
              ),
              IconButton(
                iconSize: 30,
                color: Color.fromARGB(255, 112, 65, 238),
                onPressed: () {},
                icon: Icon(Icons.notifications),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.roomNumber,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref()
                      .child("${widget.deviceId}/${widget.roomId}_relay")
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CupertinoSwitch(
                          value: snapshot.data!.snapshot.value == 1
                              ? true
                              : snapshot.data!.snapshot.value == 0
                                  ? false
                                  : false,
                          onChanged: (bool value) {
                            setState(() {
                              _lights = value;
                              if (value == true) {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child(
                                        "${widget.deviceId}/${widget.roomId}_relay")
                                    .set(1);
                              } else {
                                FirebaseDatabase.instance
                                    .ref()
                                    .child(
                                        "${widget.deviceId}/${widget.roomId}_relay")
                                    .set(0);
                              }
                            });
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Live Power Metrics",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashBoardCard1(
                power: double.parse(power) > 1000
                    ? double.parse(
                        (double.parse(power) / 1000.0).toStringAsFixed(2))
                    : double.parse((double.parse(power)).toStringAsFixed(2)),
                sym: double.parse(power) > 1000 ? 'kW' : 'W',
              ),
              Column(
                children: [
                  DashBoardCard2(
                    boxColor: Color.fromARGB(255, 0, 190, 250),
                    value:
                        double.parse(double.parse(voltage).toStringAsFixed(2)),
                    title: 'Voltage',
                    symb: 'V',
                  ),
                  DashBoardCard2(
                    boxColor: Color.fromARGB(255, 250, 0, 90),
                    value:
                        double.parse(double.parse(current).toStringAsFixed(2)),
                    title: 'Current',
                    symb: 'A',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          EmptyGreyCard(
            CardHeight: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text(
                    "Total Energy consumption",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "from : " + date,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Text(
                        energy + " Wh",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 112, 65, 238)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Set Threshold Current",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child("${widget.deviceId}/${widget.roomId}_threshold")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return EmptyGreyCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Threshold Current Limit",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data!.snapshot.value.toString() +
                                      " A",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 250, 0, 90)),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Adjust",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 250, 0, 90)),
                                  ),
                                  IconButton(
                                      color: Color.fromARGB(255, 250, 0, 90),
                                      onPressed: () {
                                        TextEditingController _controller =
                                            TextEditingController();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Set Current Threshold"),
                                                content: TextField(
                                                    controller: _controller,
                                                    keyboardType:
                                                        TextInputType.number),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        FirebaseDatabase
                                                            .instance
                                                            .ref()
                                                            .child(
                                                                "${widget.deviceId}/${widget.roomId}_threshold")
                                                            .set(double.parse(
                                                                _controller
                                                                    .text))
                                                            .then((value) =>
                                                                Navigator.pop(
                                                                    context));
                                                      },
                                                      child: Text("Set"))
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.edit_document,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      CardHeight: 100);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
