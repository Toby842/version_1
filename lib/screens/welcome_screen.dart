//Import Flutter libraries:
import 'package:flutter/material.dart';

//Import other Files
import 'package:version_1/globals.dart';
import 'package:version_1/screens/create_sandwich.dart';
import 'package:version_1/screens/favourite_sandwich.dart';


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
  const StartScreen({super.key, required this.functioN});

  final Function functioN;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>{

  updateWelcomeScreen() {
    setState(() {});
    widget.functioN();
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
                  if (fillStand["1"] != 0) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateSandwich(function: updateWelcomeScreen))); 
                      newSandwich.clear();
                      newSandwich.add(0);
                      fillStandCopy = Map.from(fillStand);
                      fillStandCopy['1'] = fillStandCopy['1'] - 1;
                      prepareIn = '0030';
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: (language == 'English') 
                              ? RichText(
                                text: const TextSpan(
                                  text: 'WARNING: ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'The bread-dispenser is empty.',
                                      style: TextStyle(
                                        color: Colors.black87
                                      )
                                    )
                                  ]
                                ),
                              )
                              : RichText(
                                text: const TextSpan(
                                  text: 'WARNUNG: ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Der Brot-Dispenser ist leer.',
                                      style: TextStyle(
                                        color: Colors.black87
                                      )
                                    )
                                  ]
                                ),
                              )
                            ),
                          )
                        ); 
                      }
                    );
                  }
                },
                child: Center(
                  child: (language == 'English') 
                  ? const Text(
                      "New sandwich",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  : const Text(
                    "Neues Sandwich",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  )
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
                  return FavouriteSandwiches(index_: index, function: updateWelcomeScreen,);
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
  const FavouriteSandwiches({super.key, required this.index_, required this.function});

  final int index_;
  final Function function;

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
            InkWell(
              onTap: () {
                prepareIn = '0030';
                fillStandCopy = Map.from(fillStand);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouriteSandwichesStored(favouriteName: favourites[index_.toString()], favouriteIndex: index_, favouriteList: favouritesData[favourites[index_]], function: function,)));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.09 - 20,
                child: Center(
                  child: Image.asset(
                    'assets/icons/sandwich.png',
                    fit: BoxFit.contain,
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