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
      backgroundColor: const Color(0xfff2f3f4),
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

            Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.4,
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateSandwich())); 
                      newSandwich.clear();
                },
                child: const Center(
                  child: Text(
                       "New Sandwich",
                       style: TextStyle(
                         color: Colors.black87,
                         fontSize: 15,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.009,
              width: MediaQuery.of(context).size.width,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.255,
              width: MediaQuery.of(context).size.width * 0.8,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(favourites.length, (index) {
                  return FavouriteSandwiches(index_: index);
                })
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            )
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
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.height * 0.15,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: ListTile(
                leading: const Icon(
                  Icons.star_outline_outlined,
                  color: Colors.red,
                ),
                title: Transform.translate(
                  offset: const Offset(-30, 0),
                  child: Text(
                    favourites[index_],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09 - 20,
              child: Center(
                child: Text(
                  'what to show?',
                  style: TextStyle(
                    color: Colors.grey.withOpacity(1),
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}