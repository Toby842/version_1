//Import Flutter libraries:
import 'package:flutter/material.dart';

//Import other Files
import 'package:version_1/globals.dart';
import 'package:version_1/screens/create_sandwich.dart';

//======================================================================
//This builds the screen that is seen first when the App starts. 
//From here, the user can navigate to every other screen.
//
//In the column every child has a height that is defined with MediaQuery and a number multiplicated with it.
//MediaQuery.of(context).size.height means, that it will use the whole height of the screen. The number that is multiplicated 
//is the percentage that is needed for the widget. That means all the numbers together in one screen must always add up to exactly the
//number 1. Otherwise we will get an Pixel-Overflow-Error.
//The Benefit of this is, that the App adjusts to different Screensizes automatically.
//======================================================================


///STartScreen is the anchor for the UI of the Start screen. All other functions are impelmented in here that have to do with the Welcome Screen
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: const FittedBox(
                child: Text(
                  "Sandi SM-1200",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.476,
              width: MediaQuery.of(context).size.width,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.5,
              child: FittedBox(
                child: ElevatedButton(
                  ///if the button is pressed, the screen will change to the New-Sandwich-Interface
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateSandwich())); newSandwich.clear();
                  }, 
                  style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black87),
                        ),
                  child: const Text(
                    "New Sandwich",
                    style: TextStyle(
                      color: Colors.black87
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
              width: MediaQuery.of(context).size.width,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.001,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.black87,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
                      "Favourites",
                      style: TextStyle(
                          color: Colors.black87,
                      ),
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.315,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                itemCount: favourites.length,
                itemBuilder: ((context, index) {
                  return FavouriteSandwiches(index_: index,);
                })
              ),
            ),
        ], 
      ),
    );
  }
}


///Widget that builds the Graphics for favourite Sandwiches, that were already created
class FavouriteSandwiches extends StatelessWidget {
  const FavouriteSandwiches({super.key, required this.index_});

  final int index_;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: Colors.black87
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              favourites[index_],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.black87
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
          ],
        ),
      ),
    );
  }
}