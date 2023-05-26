//Import Flutter libraries:
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';

//other files:
import 'package:version_1/globals.dart';

//========================================================================
//This file contains the function that builds the "Settings"-Screen
//
//For MediaQuery read discription at welcome_screen.dart
//========================================================================

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  bool isConnecting = false;
  BluetoothCharacteristic? characteristic;
  String sendData = "Heyo";

  // Method to start scanning for devices
  void scanForDevices() {
    if (startedScanning == false) {
      flutterBlue.startScan();
      startedScanning = true;
    }
  }

  void _connectToDevice(BluetoothDevice device_) async {
    connectedDevice = device_;
    setState(() {
      isConnecting = true;
    });
    try {
      await device_.connect();
      setState(() {
        isConnecting = false;
      });
      discoverServices();
      // Do something with the connected device
    } catch (e) {
      setState(() {
        isConnecting = false;
      });
      // Handle the connection error
    }
  }

  void discoverServices() async {
    if (connectedDevice != null) {
      List<BluetoothService> services = await connectedDevice!.discoverServices();
      services.forEach((service) {

        ///GATT Service UUID
        if (service.uuid.toString() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() == "0000ffe1-0000-1000-8000-00805f9b34fb") {
              setState(() {
                this.characteristic = characteristic;
                characteristicGloabl = characteristic;
              });
            }
          });
        }
      });
    }
  }

  void sendDataToBLE() async {
    if (characteristic != null) {
      List<int> bytes = utf8.encode(sendData);
      await characteristic!.write(bytes, withoutResponse: true);
    }
  }

  @override
  void initState() {
    super.initState();

    // Start scanning for devices when the page is opened
    scanForDevices();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f3f4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
            ),

            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const FittedBox(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.019,
            width: MediaQuery.of(context).size.width,
          ),

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  child: const FittedBox(
                    child: Text(
                      "Bluetooth",
                      style: TextStyle(
                          color: Colors.black87,
                      ),
                    ),
                  )),
                ],
              ),
            ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.841,
            width: MediaQuery.of(context).size.width,
            child: Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: flutterBlue.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('Not connected to the stream');
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    final devices = snapshot.data
                            ?.map((result) => result.device)
                            ?.where((device) => device.name.isNotEmpty)
                            ?.toList() ??
                        [];
                    return ListView.builder(
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(2, 2),
                              )
                            ],
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: const Color(0xffffffff)
                          ),
                          child: (device == connectedDevice)
                          ? ListTile(
                            title: Text(
                              device.name,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red
                              ),
                            ),
                            subtitle: Text(
                              device.id.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: isConnecting
                                ? null
                                : () => _connectToDevice(device),
                            // trailing: 
                            // device == connectedDevice ? 
                            // ElevatedButton(
                            //   onPressed: () {
                            //     sendDataToBLE();
                            //   },
                            //   child: 
                            //   const Text('Send data'),
                            // ) : const SizedBox(
                            //   height: 1,
                            // )
                          )
                          : ListTile(
                            title: Text(
                              device.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              device.id.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: isConnecting
                                ? null
                                : () => _connectToDevice(device),
                          )
                        );
                      },
                    );
                  case ConnectionState.done:
                    return const Text('Stream is closed');
                }
              },
            ),
          ),
          ),

        ],
      ),
    );
  }
}