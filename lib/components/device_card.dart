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
                height: 170,
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
                          Text(deviceName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
