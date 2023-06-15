//Import Flutter libraries:
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:string_validator/string_validator.dart';
//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

//Import other files:
import 'package:version_1/globals.dart';

//================================================================
//DispenserInfo is the function for the screen that shows the dispenser information.
//The user can see all information about the fill-level, what´s in the dispensers and so on
//================================================================
 

class DispenserInfo extends StatefulWidget {
  const DispenserInfo({ required Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<DispenserInfo> createState() => DispenserInfoState();
}

class DispenserInfoState extends State<DispenserInfo> with TickerProviderStateMixin{
  
  ///PageController for DispenserIngrediants
  final PageController _controller = PageController(initialPage: 4);



  methodA() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///that prevents a pixel-overflow when the keyboard appears. 
      resizeToAvoidBottomInset: false,

      backgroundColor: const Color(0xfff2f3f4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
            ),

            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const FittedBox(
                    child: Text(
                      "Dispenser",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.02,
              )
            ],
          ),

          ///The Rotation Animation
          ///this is, where the user can swipe through the dispensers of the robot. 
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.528 - 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                  child: FittedBox(
                    child: imagePrecached == true 
                    ? ImageView360(
                        key: UniqueKey(),
                        imageList: imageList,
                        autoRotate: false,
                        frameChangeDuration: const Duration(milliseconds: 1),
                        swipeSensitivity: 5,
                        rotationDirection: RotationDirection.anticlockwise,
                        allowSwipeToRotate: true,
                        onImageIndexChanged: (currentImageIndex) {
                          if (235 <= currentImageIndex! || currentImageIndex <= 59) {
                            _controller.animateToPage(4, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                          if (60 <= currentImageIndex && currentImageIndex <= 129) {
                            _controller.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                          if (130 <= currentImageIndex && currentImageIndex <= 179) {
                            _controller.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                          if (180 <= currentImageIndex && currentImageIndex <= 209) {
                            _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                          if (210 <= currentImageIndex && currentImageIndex <= 234) {
                            _controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                        },
                      ) 
                    : const SizedBox(),

                  ),
                ),
              )
            ),

            ///this is where the dispenser-info of each dispenser is shown. 
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.352 + 30,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.303 + 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        DispenserContent(number: 2,  editable: true,),
                        // ignore: prefer_const_constructors
                        DispenserContent(number: 3,  editable: true,),
                        // ignore: prefer_const_constructors
                        DispenserContent(number: 4,  editable: true,),
                        // ignore: prefer_const_constructors
                        DispenserContent(number: 5,  editable: true,),
                        // ignore: prefer_const_constructors
                        DispenserContent(number: 1,  editable: false,),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.031,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}




///Widget for the content of the dispenser
class DispenserContent extends StatefulWidget {
  const DispenserContent({
    super.key, 
    required this.number,
    required this.editable,
  });

  final int number;
  final bool editable;

  @override
  State<DispenserContent> createState() => _DispenserContentState();
}

class _DispenserContentState extends State<DispenserContent> {

  final _textEditingController = TextEditingController();
  final _textEditingController2 = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void updater() {
    setState(() {});
  }

  ///function for changing the name of the ingredient
  void changeIngrediant() {
    if (widget.editable == true) {
      _textEditingController.text = '';
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(

            title: ListTile(
              horizontalTitleGap: 0,
              title: (language == 'English')
              ? const Text(
                  "Ingredient:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                )
              : const Text(
                  "Inhalt:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),

              subtitle: (language == 'English') 
              ? Text(
                "${typeTranslations[(widget.number).toString()]}-Dispenser",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12
                ),
              )
              : Text(
                "${typeTranslations[(widget.number * 11).toString()]}-Dispenser",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12
                ),
              )
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
              onSubmitted: (value) async {
                if (value != '') {
                  dispenserIngredients[(widget.number - 1).toString()] = value;
                } else {
                  dispenserIngredients[(widget.number - 1).toString()] = 'Leer';
                }

                ///store data
                Database database = await openDatabase('sandiSM1200.db');
                await database.transaction((txn) async {
                  final String data = json.encode(dispenserIngredients);
                  await txn.rawUpdate(
                    'UPDATE sandiSM1200 SET aMap = ?, key1 = ? WHERE key1 = ?',
                    [
                      data,
                      "dispenserIngredientsStored",
                      "dispenserIngredientsStored",
                    ]
                  );
                });

                updater();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
          );
        }
      );
    }
  }


  ///function for changing the image of the ingredient
  void changeImage() {
    if (widget.editable == true) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            content: StatefulBuilder(
              // ignore: non_constant_identifier_names
              builder: (BuildContext context, StateSetter SBsetState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          title: const Text(
                            "Icon:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: (language == 'English') 
                          ? Text(
                            "${typeTranslations[(widget.number).toString()]}-Dispenser",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12
                            ),
                          )
                          : Text(
                            "${typeTranslations[(widget.number * 11).toString()]}-Dispenser",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12
                            ),
                          )
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                
                        Expanded(
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(imageLibrary.length, (index) {
                              return InkWell(
                                onTap: () async {
                                  ingrediantSettings[(widget.number).toString()] = imageLibrary[index];

                                  ///store data
                                  Database database = await openDatabase('sandiSM1200.db');
                                  await database.transaction((txn) async {
                                    final String data = json.encode(ingrediantSettings);
                                    await txn.rawUpdate(
                                      'UPDATE sandiSM1200 SET aMap = ?, key1 = ? WHERE key1 = ?',
                                      [
                                        data,
                                        "ingredientSettingsStored",
                                        "ingredientSettingsStored",
                                      ]
                                    );
                                  });

                                  updater();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  child: Image.asset(
                                    imageLibrary[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            })
                          ),
                        )
                      ]
                  ),
                );
              },
            ),
          );
        }
      );
    }
  }


  ///function for setting the fill-stand
  void setFillStand() {
    _textEditingController2.text = '';
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            // ignore: non_constant_identifier_names
            builder: (BuildContext context, StateSetter SBsetState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xffffffff),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        horizontalTitleGap: 0,
                        title: (language == 'English') 
                        ? const Text(
                          "Fill-level:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        : const Text(
                          "Füllstand:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        subtitle: (language == 'English') 
                        ? Text(
                          "${typeTranslations[(widget.number).toString()]}-Dispenser",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12
                          ),
                        )
                        : Text(
                          "${typeTranslations[(widget.number * 11).toString()]}-Dispenser",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12
                          ),
                        )
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      ListTile(
                        title: TextField(
                          controller: _textEditingController2,
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            labelText: '${fillStand[(widget.number).toString()].toString()} / ${fillRefference[(widget.number).toString()]}',
                            labelStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            ),
                        ),
                        onSubmitted: (value) async {
                          if (value != '' && isNumeric(value)) {
                            fillStand[(widget.number).toString()] = int.parse(value);
                          } else {
                            fillStand[(widget.number).toString()] = fillStand[widget.number];
                          }

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

                          updater();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        ),
                        trailing: CircularPercentIndicator(
                          radius: 16,
                          lineWidth: 5,
                          animation: true,
                          percent: fillStand[(widget.number).toString()] / fillRefference[(widget.number * 11).toString()],
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.red,
                        ),
                      )
                
                      ]
                  ),
                );
              },
            ),
          );
        }
      );
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.303,
      width: MediaQuery.of(context).size.width * 0.85,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: ListTile(
              title: TextButton(
                onPressed: () {changeIngrediant();},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft
                ),

                child: (widget.number == 1) 
                ? (language == 'English') 
                  ? const Text(
                    'Bread',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )
                  : const Text(
                    'Brot',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )
                : (dispenserIngredients[(widget.number - 1).toString()] != 'Leer') 
                  ? Text(
                    dispenserIngredients[(widget.number - 1).toString()],
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )
                  : (language == 'English') 
                    ? const Text(
                      'Empty',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    )
                    : const Text(
                      'Leer',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    )
              ),

              subtitle: (language == 'English') 
              ? Text(
                "${typeTranslations[(widget.number).toString()]}-Dispenser",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12
                ),
              ) 
              : Text(
                "${typeTranslations[(widget.number * 11).toString()]}-Dispenser",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  setFillStand();
                },
                child: CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.height * 0.04 * 0.5,
                  lineWidth: 5,
                  animation: true,
                  percent: (fillStand[(widget.number).toString()] == null) 
                  ? 0 / fillRefference[(widget.number).toString()]
                  : fillStand[(widget.number).toString()] / fillRefference[(widget.number * 11).toString()],
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.red,
                ),
              ),
            ),
          ),

      InkWell(
        onTap: () {
          changeImage();
        },
        child: fillStand[(widget.number).toString()] != 0 && dispenserIngredients[(widget.number - 1).toString()] != 'Leer'
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.199,
            child: Image.asset(
              ingrediantSettings[(widget.number).toString()],
              fit: BoxFit.contain,
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.199,
            child: Stack(
              children: [
                Image.asset(
                  ingrediantSettings[(widget.number).toString()],
                  fit: BoxFit.contain,
                  color: Colors.grey.withOpacity(0.4),
                ),
              ],
            ),
          )
        ),
        ],
      ),
    );
  }
}