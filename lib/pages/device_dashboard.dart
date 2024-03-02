import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/dashboard_card_1.dart';
import 'package:power_wise/components/dashboard_card_2.dart';
import 'package:power_wise/components/rooms_card.dart';
import 'package:power_wise/pages/room_page.dart';

class DeviceDashBoard extends StatefulWidget {
  final String onlineStatus;
  final String deviceID;
  final String deviceName;
  const DeviceDashBoard(
      {super.key,
      required this.onlineStatus,
      required this.deviceID,
      required this.deviceName});

  @override
  State<DeviceDashBoard> createState() => _DeviceDashBoardState();
}

class _DeviceDashBoardState extends State<DeviceDashBoard> {
  String totalPower = "0";
  String totalCurrent = "0";
  String totalVoltage = "0";

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceID}/totalPower")
        .onValue
        .listen((event) {
      setState(() {
        totalPower = event.snapshot.value.toString();
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceID}/voltage")
        .onValue
        .listen((event) {
      setState(() {
        totalVoltage = event.snapshot.value.toString();
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("${widget.deviceID}/totalCurrent")
        .onValue
        .listen((event) {
      setState(() {
        totalCurrent = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: ListView(
          children: [
            Text(
              "Hi",
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Text(
                      "Loading...",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  }
                }),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Text(
                  widget.deviceName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 91, 224, 96)),
                    height: 12,
                    width: 12,
                  ),
                ),
                Text(widget.onlineStatus),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text('Device ID : ' + widget.deviceID),
            SizedBox(
              height: 13,
            ),
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashBoardCard1(
                  power: double.parse(totalPower) > 1000
                      ? double.parse(
                              double.parse(totalPower).toStringAsFixed(2)) /
                          1000
                      : double.parse(
                          double.parse(totalPower).toStringAsFixed(2)),
                  sym: double.parse(totalPower) > 1000 ? 'Kw' : 'W',
                ),
                Column(
                  children: [
                    DashBoardCard2(
                      boxColor: Color.fromARGB(255, 0, 190, 250),
                      value: double.parse(
                          double.parse(totalVoltage).toStringAsFixed(2)),
                      title: 'Voltage',
                      symb: 'V',
                    ),
                    DashBoardCard2(
                      boxColor: Color.fromARGB(255, 250, 0, 90),
                      value: double.parse(
                          double.parse(totalCurrent).toStringAsFixed(2)),
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
            Text(
              "Rooms",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: RoomsCard(
                roomNumber: 'Room 1',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomPage(
                              deviceId: widget.deviceID,
                              roomId: 'room1',
                              roomNumber: 'Room 1',
                            )));
              },
            ),
            GestureDetector(
              child: RoomsCard(
                roomNumber: 'Room 2',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomPage(
                              deviceId: widget.deviceID,
                              roomId: 'room2',
                              roomNumber: 'Room 2',
                            )));
              },
            ),
            GestureDetector(
              child: RoomsCard(
                roomNumber: 'Room 3',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomPage(
                              deviceId: widget.deviceID,
                              roomId: 'room3',
                              roomNumber: 'Room 3',
                            )));
              },
            ),
            GestureDetector(
              child: RoomsCard(
                roomNumber: 'Room 4',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomPage(
                              deviceId: widget.deviceID,
                              roomId: 'room4',
                              roomNumber: 'Room 4',
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
