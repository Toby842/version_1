//Import Flutter libraries:
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:string_validator/string_validator.dart';

//Import other files:
import 'package:version_1/globals.dart';

//================================================================
//DispenserInfo is the function for the screen that shows the dispenser information.
//The user can see all information about the fill-level, what´s in the dispensers and so on
//================================================================

class DispenserInfo extends StatefulWidget {
  const DispenserInfo({super.key});

  @override
  State<DispenserInfo> createState() => _DispenserInfoState();
}

class _DispenserInfoState extends State<DispenserInfo> with TickerProviderStateMixin{
  
  ///PageController for DispenserIngrediants
  final PageController _controller = PageController(initialPage: 0);


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
                          if (218 <= currentImageIndex! || currentImageIndex <= 31) {
                            _controller.animateToPage(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
                          }
                          if (32 <= currentImageIndex && currentImageIndex <= 93) {
                            _controller.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
                          }
                          if (94 <= currentImageIndex && currentImageIndex <= 155) {
                            _controller.animateToPage(2, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
                          }
                          if (156 <= currentImageIndex && currentImageIndex <= 217) {
                            _controller.animateToPage(3, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
                          }
                        },
                      ) 
                    : const SizedBox(),
                  ),
                ),
              )
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.352 + 30,
              width: MediaQuery.of(context).size.width,
              // decoration: const BoxDecoration(
              //   color: Colors.black87,
              //   borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.303 + 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        DispenserContent(number: 1, typ: 'bread', editable: false,),
                        DispenserContent(number: 2, typ: 'sauce', editable: true,),
                        DispenserContent(number: 3, typ: 'slicer', editable: true,),
                        DispenserContent(number: 4, typ: 'cheese', editable: true,),
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
    required this.typ,
    required this.editable,
  });

  final int number;
  final String typ;
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

  ///function for changing the name of the ingredient
  void changeIngrediant() {
    if (widget.editable == true) {
      _textEditingController.text = '';
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            content: StatefulBuilder(
              // ignore: non_constant_identifier_names
              builder: (context, SBsetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        horizontalTitleGap: 0,
                        title: const Text(
                          "Ingredient:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${widget.typ}-dispenser",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                
                      TextField(
                        controller: _textEditingController,
                        cursorColor: Colors.black87,
                        decoration: const InputDecoration(
                          labelText: 'Ingredient...',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value != '') {
                            dispenserIngredients[widget.number - 1] = value;
                          } else {
                            dispenserIngredients[widget.number - 1] = 'Empty';
                          }
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    ]
                );
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
              builder: (context, SBsetState) {
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
                            "Image:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${widget.typ}-dispenser",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                
                        Expanded(
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(6, (index) {
                              return InkWell(
                                onTap: () {
                                  ingrediantSettings[widget.number] = imageLibrary[index];
                                  setState(() {});
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
            builder: (context, SBsetState) {
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
                        title: const Text(
                          "Fill-Level:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        subtitle: Text(
                          "${widget.typ}-dispenser",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      ListTile(
                        title: TextField(
                          controller: _textEditingController2,
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            labelText: '${fillStand[widget.number].toString()} / ${fillRefference[widget.number]}',
                            labelStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            ),
                        ),
                        onSubmitted: (value) {
                          if (value != '' && isNumeric(value)) {
                            fillStand[widget.number] = int.parse(value);
                          } else {
                            fillStand[widget.number] = fillStand[widget.number];
                          }
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        ),
                        trailing: CircularPercentIndicator(
                          radius: 16,
                          lineWidth: 5,
                          animation: true,
                          percent: fillStand[widget.number] / fillRefference[widget.number * 11],
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
                child: Text(
                  dispenserIngredients[widget.number - 1],
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
              subtitle: Text(
                "${widget.typ}-dispenser",
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
                  percent: fillStand[widget.number] / fillRefference[widget.number * 11],
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.199,
          child: Image.asset(
            ingrediantSettings[widget.number],
            fit: BoxFit.contain,
          ),
        ),
      ),
        ],
      ),
    );
  }
}