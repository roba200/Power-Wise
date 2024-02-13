import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:power_wise/components/custom_button.dart';
import 'package:power_wise/components/device_information_card.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController passKeyController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var getResult = 'QR Code Result';

  void showErrorMessage(String? message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      "Add a New Device",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Scan the QR Code or Enter the Serial Number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          scanQRCode();
                        },
                        icon: Icon(
                          Icons.qr_code_2_sharp,
                          size: 50,
                          color: Color.fromARGB(255, 112, 65, 238),
                        )),
                    Flexible(
                        child: TextField(
                            controller: deviceIdController,
                            decoration: InputDecoration(
                              hintText: "ex:23425434335345",
                            ))),
                  ],
                ),
                Text(
                  'Note: You can Scan QR Code by clicking on above QR Icon',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Enter Passkey:',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                TextField(
                  decoration: InputDecoration(),
                  controller: passKeyController,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                    title: 'Check',
                    onPressed: () async {
                      print(await verifyDevice());
                      setState(() {});
                    }),
                SizedBox(
                  height: 50,
                ),
                FutureBuilder(
                    future: verifyDevice(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('devices')
                                  .doc(deviceIdController.text)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      DeviceInformationCard(
                                          deviceName:
                                              snapshot.data?['device_name'],
                                          serialNum:
                                              snapshot.data?['device_id'],
                                          deviceType:
                                              snapshot.data?['device_type']),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      CustomButton(
                                          title: 'Add Device',
                                          onPressed: () async {
                                            if (await checkDeviceAvailableOnUser() ==
                                                false) {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('devices')
                                                  .doc(deviceIdController.text)
                                                  .set({
                                                'device_name':
                                                    await getDeviceName(),
                                                'device_id':
                                                    await getDeviceId(),
                                                'device_type':
                                                    await getDeviceType(),
                                                'pass_key': await getPassKey()
                                              }).then((value) => showErrorMessage(
                                                      'Device Added Successfully'));
                                            } else {
                                              showErrorMessage(
                                                  'This device Already Exists!');
                                            }
                                          })
                                    ],
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        } else {
                          return Text(
                            'No Device Found!',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      } else {
                        return Text(
                          'No Device Found!',
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (!mounted) return;

      setState(() {
        deviceIdController.text = qrCode;
      });
    } on PlatformException {
      deviceIdController.text = '';
    }
  }

  Future checkAvailability() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .doc("devices/" + deviceIdController.text)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  Future getPassKey() async {
    DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
        .collection('devices')
        .doc(deviceIdController.text);

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await docRef.get();

      if (documentSnapshot.exists) {
        // Document exists, you can now access the field value
        dynamic fieldValue = documentSnapshot.data()?['pass_key'];

        if (fieldValue != null) {
          //print('Field value: $fieldValue');
          return fieldValue;
        } else {
          print('Field does not exist or is null.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Future getDeviceId() async {
    DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
        .collection('devices')
        .doc(deviceIdController.text);

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await docRef.get();

      if (documentSnapshot.exists) {
        // Document exists, you can now access the field value
        dynamic fieldValue = documentSnapshot.data()?['device_id'];

        if (fieldValue != null) {
          //print('Field value: $fieldValue');
          return fieldValue;
        } else {
          print('Field does not exist or is null.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Future getDeviceName() async {
    DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
        .collection('devices')
        .doc(deviceIdController.text);

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await docRef.get();

      if (documentSnapshot.exists) {
        // Document exists, you can now access the field value
        dynamic fieldValue = documentSnapshot.data()?['device_name'];

        if (fieldValue != null) {
          //print('Field value: $fieldValue');
          return fieldValue;
        } else {
          print('Field does not exist or is null.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Future getDeviceType() async {
    DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
        .collection('devices')
        .doc(deviceIdController.text);

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await docRef.get();

      if (documentSnapshot.exists) {
        // Document exists, you can now access the field value
        dynamic fieldValue = documentSnapshot.data()?['device_type'];

        if (fieldValue != null) {
          //print('Field value: $fieldValue');
          return fieldValue;
        } else {
          print('Field does not exist or is null.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Future verifyDevice() async {
    if (await checkAvailability()) {
      if (await getPassKey() == passKeyController.text) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future checkDeviceAvailableOnUser() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .doc("users/" + FirebaseAuth.instance.currentUser!.uid)
          .collection('devices')
          .doc(deviceIdController.text)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
