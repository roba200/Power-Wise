import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/dashboard_card_1.dart';
import 'package:power_wise/components/dashboard_card_2.dart';
import 'package:power_wise/components/device_card.dart';
import 'package:power_wise/components/empty_grey_card.dart';
import 'package:power_wise/components/rooms_card.dart';

class RoomPage extends StatefulWidget {
  final String deviceId;
  final String roomId;
  const RoomPage({
    super.key,
    required this.deviceId,
    required this.roomId,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool _lights = false;
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
                  Text(
                    "Hasindu",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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
                "Master Bedroom",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('devices')
                      .doc(widget.deviceId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CupertinoSwitch(
                          value:
                              snapshot.data![widget.roomId + "_relay"] == "on"
                                  ? true
                                  : snapshot.data![widget.roomId + "_relay"] ==
                                          "off"
                                      ? false
                                      : false,
                          onChanged: (bool value) {
                            setState(() {
                              _lights = value;
                              if (value == true) {
                                FirebaseFirestore.instance
                                    .collection('devices')
                                    .doc(widget.deviceId)
                                    .update({widget.roomId + "_relay": "on"});
                              } else {
                                FirebaseFirestore.instance
                                    .collection('devices')
                                    .doc(widget.deviceId)
                                    .update({widget.roomId + "_relay": "off"});
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
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('devices')
                  .doc(widget.deviceId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashBoardCard1(
                        power: double.parse(
                                    snapshot.data![widget.roomId + '_power']) >
                                1000
                            ? double.parse(
                                    snapshot.data![widget.roomId + '_power']) /
                                1000.0
                            : double.parse(
                                snapshot.data![widget.roomId + '_power']),
                        sym: double.parse(
                                    snapshot.data![widget.roomId + '_power']) >
                                1000
                            ? 'kW'
                            : 'W',
                      ),
                      Column(
                        children: [
                          DashBoardCard2(
                            boxColor: Color.fromARGB(255, 0, 190, 250),
                            value: double.parse(
                                snapshot.data![widget.roomId + '_voltage']),
                            title: 'Voltage',
                            symb: 'V',
                          ),
                          DashBoardCard2(
                            boxColor: Color.fromARGB(255, 250, 0, 90),
                            value: double.parse(
                                snapshot.data![widget.roomId + '_current']),
                            title: 'Current',
                            symb: 'A',
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('devices')
                  .doc(widget.deviceId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return EmptyGreyCard(
                    CardHeight: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            "Total power consumption",
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
                                snapshot.data![widget.roomId + '_energy'] +
                                    " Wh",
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
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          Text(
            "Set Threshold Current",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('devices')
                  .doc(widget.deviceId)
                  .snapshots(),
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
                                  snapshot.data![widget.roomId + '_thershold']
                                          .toString() +
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
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'devices')
                                                            .doc(
                                                                widget.deviceId)
                                                            .update({
                                                          widget.roomId +
                                                                  '_thershold':
                                                              double.parse(
                                                                  _controller
                                                                      .text)
                                                        }).then((value) =>
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
          Text(
            "Suggestions to Reduce power usage",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
