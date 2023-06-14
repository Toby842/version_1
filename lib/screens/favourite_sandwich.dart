///import flutter libraries
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';


///import other files
import 'package:version_1/globals.dart';


///===========================================================================
///this is the file where the user can handle all the stuff for the favourites.
///===========================================================================


class FavouriteSandwichesStored extends StatefulWidget {
  const FavouriteSandwichesStored({
    super.key, 
    required this.favouriteName, 
    required this.favouriteIndex, 
    required this.favouriteList,
    required this.function,
  });

  final String favouriteName;
  final int favouriteIndex;
  final List<dynamic> favouriteList;
  final Function function;

  @override
  State<FavouriteSandwichesStored> createState() => _FavouriteSandwichesStoredState();
}

class _FavouriteSandwichesStoredState extends State<FavouriteSandwichesStored> {

  bool fillStandsOkay = false;

  @override
  void initState() {
    super.initState();

    ///checks if the robot has enough ingrediants for making the sandwich
    for (int i = 0; i < widget.favouriteList.length; i++) {
      if (widget.favouriteList[i] + 1 == 2 || widget.favouriteList[i] + 1 == 3) {
        fillStandCopy[widget.favouriteList[i] + 1] -= 15;
      } else {
        fillStandCopy[widget.favouriteList[i] + 1] -= 1;
      }
      if (fillStandCopy[widget.favouriteList[i] + 1] < 0) {
        fillStandsOkay = false;
        break;
      } else {
        fillStandsOkay = true;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                  widget.favouriteName,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            ),

            //0.88 downwards

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
              width: MediaQuery.of(context).size.width,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.516,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                reverse: true,
                itemCount: widget.favouriteList.length,
                itemBuilder: ((context, index) {
                  return SandwichIngrediants2(index_: widget.favouriteList[index], indexList: index,);
                })
              ),
            ),

            ///Picking a time when the sandwich should be prepared. 
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
                          favouritesData.remove(widget.favouriteName);
                          favourites.removeAt(widget.favouriteIndex);
                          widget.function();
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                      ),

                      title: Transform.translate(
                        offset: const Offset(-30, 0),
                        child: Text(
                          widget.favouriteName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.7,

                    ///implement delete-function
                    

                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, bottom: 10),
                      child: InkWell(
                        onTap: () async {
                          // ignore: unnecessary_null_comparison
                          if (isConnected == true && newSandwich[0] == 0 && fillStandsOkay == true) {

                            fillStandSauce1 = fillStandCopy[2].toString().padLeft(2, '0');
                            fillStandSauce2 = fillStandCopy[3].toString().padLeft(2, '0');
                            //implement for Sauce2 dispenser

                            fillStand = Map.from(fillStandCopy);
                            for (int i = 0; i < newSandwich.length; i++) {
                              newSandwich[i] = newSandwich[i] + 1;
                            }
                            for (int j = newSandwich.length - 1; j < 10; j++) {
                              newSandwich.add(0);
                            }
                            List<int> bytes = utf8.encode(newSandwich.join("") + prepareIn + fillStandSauce1 + fillStandSauce2);
                            await characteristicGloabl.write(bytes, withoutResponse: true);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            debugPrint(newSandwich.join("") + prepareIn);
                          } else {
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
                            else if (newSandwich[0] != 0) {
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
                            } else {
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
                                                text: 'You do not have enough ingredients.',
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
                                                text: 'Es sind nicht genügend Zutaten in den Dispensern.',
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


///Widget for the Ingrediants that got dragged into the field
class SandwichIngrediants2 extends StatelessWidget {
  const SandwichIngrediants2({super.key, required this.index_, required this.indexList,});

  //Index for recognizing what dispenser is meant with the number
  final int index_;
  //Index in the newSandwich-List
  final int indexList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Image.asset(
            ingrediantSettings[index_ + 1],
            fit: BoxFit.contain,
          ),
    );
  }
}