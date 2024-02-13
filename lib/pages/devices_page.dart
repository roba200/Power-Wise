import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_wise/components/device_card.dart';
import 'package:power_wise/pages/add_device_page.dart';
import 'package:power_wise/pages/device_dashboard.dart';
import 'package:power_wise/pages/test_page.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int _currentIndex = 0;

  List pages = [DeviceListPage(), AddDevicePage(), TestPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }
}

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
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
                      style: TextStyle(fontSize: 24),
                    );
                  } else {
                    return Text(
                      "Loading...",
                      style: TextStyle(fontSize: 24),
                    );
                  }
                }),
            SizedBox(
              height: 60,
            ),
            Text(
              "Devices",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('devices')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return DeviceCard(
                            deviceName: snapshot.data!.docs[index]
                                ['device_name'],
                            serialNum: snapshot.data!.docs[index]['device_id'],
                            deviceType: snapshot.data!.docs[index]
                                ['device_type'],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeviceDashBoard(
                                            onlineStatus: 'online',
                                            deviceID: snapshot.data!.docs[index]
                                                ['device_id'],
                                            deviceName: snapshot.data!
                                                .docs[index]['device_name'],
                                          )));
                            },
                            onTapDelete: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      alignment: Alignment.center,
                                      title: Text("Warning!"),
                                      content: Text(
                                          "Do You really want to remove this device from your account?"),
                                      actions: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No")),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('devices')
                                                  .doc(snapshot.data!
                                                      .docs[index]['device_id'])
                                                  .delete()
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            },
                                            child: Text("Delete"))
                                      ],
                                    );
                                  });
                            },
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
