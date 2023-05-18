import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothConnectPage extends StatefulWidget {
  const BluetoothConnectPage({Key? key, })
      : super(key: key);

  @override
  _BluetoothConnectPageState createState() => _BluetoothConnectPageState();
}

class _BluetoothConnectPageState extends State<BluetoothConnectPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  bool isConnecting = false;
  BluetoothCharacteristic? characteristic;
  String sendData = "Heyo";

  // Method to start scanning for devices
  void scanForDevices() {
    //implement boolian that checks if app is already scanning
    //otherwise you will get an error if the users changes screen and comes back again
    flutterBlue.startScan();

    // You can remove the timer that stops the scan after 4 seconds
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
                print(characteristic);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Bluetooth',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Available Devices',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
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
                        return ListTile(
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
                          trailing: 
                          device == connectedDevice ? 
                          ElevatedButton(
                            onPressed: () {
                              sendDataToBLE();
                            },
                            child: 
                            const Text('Send data'),
                          ) : const SizedBox(
                            height: 1,
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
          if (isConnecting)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (connectedDevice != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Connected to: ${connectedDevice!.name}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
        ],
      ),
    );
  }
}