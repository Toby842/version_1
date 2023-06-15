//Import the flutter libraries:
import 'package:flutter/material.dart';

//Import other files:
import 'package:version_1/screens/settings.dart';
import 'package:version_1/screens/dispenser_info.dart';
import 'package:version_1/screens/welcome_screen.dart';
import 'package:version_1/globals.dart';

GlobalKey<DispenserInfoState> globalKey = GlobalKey();


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
    ///images for the rotation animation must be loaded and stored.
    WidgetsBinding.instance.addPostFrameCallback((_) {loadImages(); });
    super.initState();
  }

  ///It would be best to load the entire list when the app is launching. That is what´s happening here
  void loadImages() async {
    for (int i = 300; i >= 1; i--) {
      imageList.add(AssetImage('assets/dispenserSequenceNew/${i.toString().padLeft(4, '0')}.png'));
      await precacheImage(AssetImage('assets/dispenserSequenceNew/${i.toString().padLeft(4, '0')}.png'), context);
    }
    imagePrecached = true;
    setState(() {});
  }

  void updateAnchor() {
    setState(() {});
    globalKey.currentState?.methodA();
  }

  @override
  Widget build(BuildContext context) {
    return 
    imagePrecached == true 

    ///if everything is fetched, the app can launch
    ? PageView(
      controller: _controller,
      children: [
        DispenserInfo(key: globalKey,),
        StartScreen(functioN: updateAnchor,),
        Settings(function: updateAnchor,), 
      ],
    )

    ///if there is still data missing, the app will not launch
    : const Scaffold(
      backgroundColor: Color(0xfff2f3f4),
    )
    ;
  }
}