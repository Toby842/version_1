///Import flutter libraries:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

///Import other files:
import 'package:version_1/globals.dart';

///====================================================
///This displays the UI where the user can create the sandwich.
///====================================================


///Main Widget
class CreateSandwich extends StatefulWidget {
  const CreateSandwich({super.key, required this.function});

  final Function function;

  @override
  State<CreateSandwich> createState() => _CreateSandwichState();
}

class _CreateSandwichState extends State<CreateSandwich> {

  bool isFavourite = false;
  final _textEditingController = TextEditingController();
  String potentialFavouriteName = "";

  deleteItem(int deleteItem, int indexFillstand) {
    setState(() {
      newSandwich.removeAt(deleteItem);
      if (indexFillstand + 1 == 2 || indexFillstand + 1 == 3) {
        fillStandCopy[(indexFillstand + 1).toString()] = fillStandCopy[(indexFillstand + 1).toString()] + 15;
      } else {
        fillStandCopy[(indexFillstand + 1).toString()] = fillStandCopy[(indexFillstand + 1).toString()] + 1;
      }
      
    });
  }

  ///function that builds the main structure:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///this is to not get a pixel-overflow, if the keyboard appears. 
      resizeToAvoidBottomInset: false,

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
              child: FittedBox(
                child: (language == 'English') 
                ? const Text(
                  "New sandwich",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                )
                : const Text(
                  "Neues Sandwich",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                )
              ),
            ),

            //0.88 downwards

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width,
            ),

            ///Here the options for the ingrediants appear. If a dispenser is filled and has a name, 
            ///the user can drag the ingrediant into the drag-target
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.height * 0.9,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
                child: Center(
                  child: ListView.builder(
                    itemCount: dispenserIngredients.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return DispenserIngredientsUI(index_: index,);
                    })
                  ),
                ),
              ),
            ),

            ///This is the Drag-target. The user drags the ingrediants into this SizedBox and
            ///lets go. The ingrediant gets added to the list newSandwich and newSandwich is 
            ///built with ListView.builder. For each list-entry the Widget SandwichIngrediants is
            ///built. 
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.466,
              width: MediaQuery.of(context).size.width,
              child: DragTarget<int>(
                builder: (BuildContext context, List<dynamic> accepted,List<dynamic> rejected) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: newSandwich.length,
                    itemBuilder: ((context, index) {
                      return SandwichIngrediants(index_: newSandwich[index], indexList: index, function: deleteItem,);
                    })
                  );
                },

                ///ingrediant gets added to newSandwich (List) + Fillstandcopy gets updated
                onAccept: (int data) {
                  if (newSandwich.length < 10) {
                    newSandwich.add(data);
                    if (data + 1 == 2 || data + 1 == 3) {
                      fillStandCopy[(data + 1).toString()] = fillStandCopy[(data + 1).toString()] - 15;
                    } else {
                      fillStandCopy[(data + 1).toString()] = fillStandCopy[(data + 1).toString()] - 1;
                    }
                    setState(() {});
                  }
                },

              ),
            ),

            ///Container, where the user can set the time, when the sandwich should be prepared.
            ///He sets the hours and minutes that should pass until the robot starts the creating-
            ///process.
            Container(
              height: MediaQuery.of(context).size.height * 0.101,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 19, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (language == 'English') 
                    ? const Text(
                      'Prepared in:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                    : const Text(
                      'Zubereitet in:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const Spacer(),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.time,
                      initTime: DateTime.utc(1, 1, 1, 00, 30),
                      onChange: (dateTime) {
                        prepareIn = (dateTime.hour * 60 + dateTime.minute).toString().padLeft(4, '0');
                      },
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.014,
              width: MediaQuery.of(context).size.width,
            ),

            ///Container, where the user can decide, if he wants to store the sandwich as a favourite
            ///and give it a name. The create-button is also located in this container. 
            Container(
              height: MediaQuery.of(context).size.height * 0.159,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ListTile(
                      leading: InkWell(
                        onTap: () {
                          if (isFavourite == false) {
                            isFavourite = true;
                            _textEditingController.text = "";
                            potentialFavouriteName = "";
                          } else {
                            isFavourite = false;
                          }
                          setState(() {});
                        },
                        child: (isFavourite == false) 
                        ? const Icon(
                          Icons.star_border_outlined,
                          color: Colors.black87,
                        ) 
                        : const Icon(
                          Icons.star_border_outlined,
                          color: Colors.red,
                        ),
                      ),

                      title: Transform.translate(
                        offset: const Offset(-30, 0),
                        child: (language == 'English') 
                        ? const Text(
                          'Add to favorites:',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12
                          ),
                        )
                        : const Text(
                          'Für später speichern:',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12
                          ),
                        )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: (isFavourite == true) 
                    ? Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          _textEditingController.text = "";
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: (language == 'English') 
                                ? const Text(
                                  "Name your sandwich:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                )
                                : const Text(
                                  "Benenne dein Sandwich:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: TextField(
                                  controller: _textEditingController,
                                    cursorColor: Colors.black87,
                                    decoration: const InputDecoration(
                                      labelText: '',
                                      labelStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                    onSubmitted: (value) {
                                      potentialFavouriteName = value;
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                ) 
                              );
                            }
                          );
                        },
                        child: RichText(
                        text: TextSpan(
                          text: 'Name: ',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: potentialFavouriteName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal
                              )
                            )
                          ]
                        ),
                      ),
                    ))
                    : const SizedBox()
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, bottom: 10),
                      child: InkWell(
                        onTap: () async {

                          ///Here the app checks, if everything is ready for sending the data to the robot. 
                          ///The app has to be connected to the robot, all dispensers have to be filled enough
                          ///to create the sandwich. The first ingrediant of the sandwich needs to be bread. 

                          // ignore: unnecessary_null_comparison
                          if (isConnected == true && newSandwich[0] == 0) {

                            if (isFavourite == true && potentialFavouriteName != "" && favouritesData.containsKey(potentialFavouriteName) == false) {
                              favourites[favourites.length.toString()] = potentialFavouriteName;
                              favouritesData[potentialFavouriteName] = List.from(newSandwich);

                              ///store data
                              Database database = await openDatabase('sandiSM1200.db');
                              await database.transaction((txn) async {
                                final String data = json.encode(favourites);
                                await txn.rawUpdate(
                                  'UPDATE sandiSM1200 SET aMap = ?, key1 = ? WHERE key1 = ?',
                                  [
                                    data,
                                    "favouritesStored",
                                    "favouritesStored",
                                  ]
                                );
                              });

                              ///store data
                              Database database2 = await openDatabase('sandiSM1200.db');
                              await database2.transaction((txn) async {
                                final String data = json.encode(favouritesData);
                                await txn.rawUpdate(
                                  'UPDATE sandiSM1200 SET aMap = ?, key1 = ? WHERE key1 = ?',
                                  [
                                    data,
                                    "favouritesIngredientsStored",
                                    "favouritesIngredientsStored",
                                  ]
                                );
                              });
                            }

                            fillStandSauce1 = fillStandCopy[2].toString().padLeft(2, '0');
                            fillStandSauce2 = fillStandCopy[3].toString().padLeft(2, '0');

                            fillStand = Map.from(fillStandCopy);

                            ///store data
                            Database database = await openDatabase('sandiSM1200.db');
                            await database.transaction((txn) async {
                              final String data = json.encode(fillStand);
                              await txn.rawUpdate(
                                'UPDATE sandiSM1200 SET aMap = ?, key1 = ? WHERE key1 = ?',
                                [
                                  data,
                                  "fillStandStored",
                                  "fillStandStored",
                                ]
                              );
                            });

                            for (int i = 0; i < newSandwich.length; i++) {
                              newSandwich[i] = newSandwich[i] + 1;
                            }
                            for (int j = newSandwich.length - 1; j < 9; j++) {
                              newSandwich.add(0);
                            }
                            List<int> bytes = utf8.encode(newSandwich.join("") + prepareIn);
                            await characteristicGloabl.write(bytes, withoutResponse: true);
                            widget.function();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            debugPrint(newSandwich.join("") + prepareIn);
                          } 

                          ///otherwise the user will get error-Messages:
                          
                          ///error: not connected to robot
                          else {
                            if (isConnected == false) {
                              Navigator.of(context).pop();
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
                                                text: 'You are not connected to Sandi SM-1200.',
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
                                                text: 'Du bist nicht mit Sandi SM-1200 verbunden.',
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

                            ///error: bread is not the first ingrediant
                            if (newSandwich[0] != 0) {
                              Navigator.of(context).pop();
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
                                                text: 'Bread must be the first ingredient.',
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
                                                text: 'Brot muss die erste Zutat des Sandwiches sein.',
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
                          } 
                        },
                        child: (language == 'English') 
                        ? const Text(
                          'Prepare',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                        : const Text(
                          'Fertig',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      ),
                    ),
                  )

                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width,
            )
        ],
      ),
    );
  }
}

///Widget that displays the ingrediant-options the user set. They appear on the top-side of the 
///page and can be dragged into the drag-target.
class DispenserIngredientsUI extends StatelessWidget {
  const DispenserIngredientsUI({super.key, required this.index_});

  final int index_;

  @override
  Widget build(BuildContext context) {
    return fillStandCopy[(index_ + 1).toString()] != 0 && dispenserIngredients[index_.toString()] != 'Leer' ?

    ///if everything is fine, the user can drag one ingrediant a time into the drag-target
    Draggable<int>(
      maxSimultaneousDrags: 1,
      data: index_,

      feedback: SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Image.asset(
            ingrediantSettings[(index_ + 1).toString()],
            fit: BoxFit.contain,
          )
    ),

      childWhenDragging: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              )
            ]
          ),
          child: Center(
            child: (index_ != 0) 
            ? Text(
              dispenserIngredients[index_.toString()],
              style: TextStyle(
                color: Colors.black87,
                fontSize: MediaQuery.of(context).size.height * 0.01,
                fontWeight: FontWeight.bold
              ),
            )
            : (language == 'English') 
              ? Text(
                'Bread',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
              : Text(
                'Brot',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
        ),

      child: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              )
            ]
          ),
          child: Center(
            child: (index_ != 0) 
            ? Text(
              dispenserIngredients[index_.toString()],
              style: TextStyle(
                color: Colors.black87,
                fontSize: MediaQuery.of(context).size.height * 0.01,
                fontWeight: FontWeight.bold
              ),
            )
            : (language == 'English') 
              ? Text(
                'Bread',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
              : Text(
                'Brot',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
        ),
    )

    ///is something is not right, the user cannot drag the container. 

    : Draggable<int>(
      maxSimultaneousDrags: 0,
      data: index_,

      feedback: const SizedBox(),

      child: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color.fromARGB(255, 226, 226, 221),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              )
            ]
          ),
          child: Center(
            child: (dispenserIngredients[index_.toString()] == 'Leer') 
            ? (language == 'English') 
              ? Text(
                'Empty',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
              : Text(
                'Leer',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
            : (index_ != 0) 
              ? Text(
                dispenserIngredients[index_.toString()],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
              : (language == 'English') 
              ? Text(
                'Bread',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
              : Text(
                'Brot',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
        ),
    );
  }
}


///Widget for the Ingrediants that got dragged into the field. They are the list items of newSandwich. 
///The user sees the icon of the ingrediant in ListView.builder.
class SandwichIngrediants extends StatelessWidget {
  const SandwichIngrediants({super.key, required this.index_, required this.indexList, required this.function});

  //Index for recognizing what dispenser is meant with the number
  final int index_;
  //Index in the newSandwich-List
  final int indexList;
  ///function for setting state. 
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        function(indexList, index_);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Image.asset(
              ingrediantSettings[(index_ + 1).toString()],
              fit: BoxFit.contain,
            ),
      ),
    );
  }
}