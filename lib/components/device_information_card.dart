import 'package:flutter/material.dart';
import 'package:power_wise/components/custom_button_2.dart';

class DeviceInformationCard extends StatelessWidget {
  final String deviceName;
  final String serialNum;
  final String deviceType;
  const DeviceInformationCard(
      {super.key,
      required this.deviceName,
      required this.serialNum,
      required this.deviceType});

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
            height: 170,
            width: screenWidth,
            color: Colors.transparent,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                            width: screenWidth * 0.25,
                            height: screenWidth * 0.25,
                            child: deviceType == "mcb"
                                ? Image.asset('images/processor.png')
                                : Image.asset('images/suplement.jpg')),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Device Name : ' + deviceName,
                                style: TextStyle(
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Device Type : ' + deviceType,
                                style: TextStyle(
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Device ID: ' + serialNum,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton2(
                      title: "Change Device Name", onPressed: () {}),
                ),
              ],
            ),
          ),
        ));
  }
}
