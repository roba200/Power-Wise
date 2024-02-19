import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String serialNum;
  final String deviceType;
  final Function()? onTap;
  final Function()? onTapDelete;
  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.serialNum,
    required this.deviceType,
    required this.onTap,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
            color: Color.fromARGB(255, 252, 252, 252),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: screenWidth,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: screenWidth * 0.4,
                        height: screenWidth * 0.4,
                        child: deviceType == "mcb"
                            ? Image.asset('images/processor.png')
                            : Image.asset('images/suplement.jpg')),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: IconButton(
                              onPressed: onTapDelete,
                              icon: Icon(Icons.delete),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Set Device Name'),
                                            content: TextField(
                                              controller: _nameController,
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Canel")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection('devices')
                                                        .doc(serialNum)
                                                        .update({
                                                      'device_name':
                                                          _nameController.text
                                                    }).then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text("Set"))
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.edit)),
                              Text(deviceName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(serialNum,
                              style: TextStyle(
                                fontSize: 13,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
