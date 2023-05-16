//Import the flutter libraries:
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

//Import other files:
import 'package:version_1/screens/settings.dart';
import 'package:version_1/screens/dispenser_info.dart';
import 'package:version_1/screens/welcome_screen.dart';
import 'package:version_1/globals.dart';
import 'bluetooth_connection_page.dart';

//=================================================================
//Anchor is the anchor for the three front pages
//This function is responsible that one can swipe through the three screens and navigate to all the other screens of the app
//=================================================================

class Anchor extends StatefulWidget {
  const Anchor({super.key, });


  @override
  State<Anchor> createState() => _AnchorState(); 
}

class _AnchorState extends State<Anchor> {
  final PageController _controller = PageController(initialPage: 1);

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {loadImages(); });
    super.initState();
  }

  ///It would be best to load the entire list when the app is launching. 
  void loadImages() async {
    for (int i = 248; i >= 1; i--) {
      imageList.add(AssetImage('assets/dispenserSequence/$i.png'));
      await precacheImage(AssetImage('assets/dispenserSequence/$i.png'), context);
    }
    imagePrecached = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return 
    imagePrecached == true 
    ? PageView(
      controller: _controller,
      children: [
        const DispenserInfo(),
        const StartScreen(),
        const Settings(), 
        BluetoothConnectPage(),
      ],
    )
    : const Scaffold(
      backgroundColor: Colors.white,
    )
    ;
  }
}