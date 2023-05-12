import 'dart:developer';

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

  // Method to start scanning for devices
  void scanForDevices() {
    flutterBlue.startScan();

    // You can remove the timer that stops the scan after 4 seconds
  }

  void _connectToDevice(BluetoothDevice device) async {
    setState(() {
      isConnecting = true;
    });
    try {
      await device.connect();
      setState(() {
        connectedDevice = device;
        isConnecting = false;
      });
      // Do something with the connected device
    } catch (e) {
      setState(() {
        isConnecting = false;
      });
      // Handle the connection error
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
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Send data'),
                          ),
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