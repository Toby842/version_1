///Import flutter libraries:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'dart:convert';

///Import other files:
import 'package:version_1/globals.dart';
import 'package:version_1/screens/anchor.dart';

///====================================================
///This displays the UI where the user can create the sandwich.
///====================================================


class CreateSandwich extends StatefulWidget {
  const CreateSandwich({super.key});

  @override
  State<CreateSandwich> createState() => _CreateSandwichState();
}

class _CreateSandwichState extends State<CreateSandwich> {

  bool isFavourite = false;
  final _textEditingController = TextEditingController();


  deleteItem(int deleteItem) {
    setState(() {
      newSandwich.removeAt(deleteItem);
    });
  }



  ///function that builds the main structure:
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
              child: const FittedBox(
                child: Text(
                  "New Sandwich",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            ),

            //0.88 downwards

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width,
            ),

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
                onAccept: (int data) {
                  newSandwich.add(data);
                  setState(() {});
                },
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.101,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                //border: Border.all(color: Colors.black87),
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Prepare in:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.time,
                      initTime: DateTime.now(),
                      onChange: (dateTime) {},
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
                          if (isFavourite == false) {
                            isFavourite = true;
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
                        child: const Text(
                          'Make it a favourite',
                          style: TextStyle(
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
                    child: (isFavourite == true) 
                    ? TextField(
                      controller: _textEditingController,
                        cursorColor: Colors.black87,
                        decoration: const InputDecoration(
                          labelText: 'name your sandwich',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          ),
                        ),
                        onSubmitted: (value) {
                        },
                    ) 
                    : const SizedBox(),
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: InkWell(
                        onTap: () async {
                          print(newSandwich);
                          // ignore: unnecessary_null_comparison
                          if (characteristicGloabl != null) {
                            List<int> bytes = utf8.encode(newSandwich.toString());
                            await characteristicGloabl.write(bytes, withoutResponse: true);
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => const Anchor()));
                        },
                        child: const Text(
                          'Create'
                        ),
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


class DispenserIngredientsUI extends StatelessWidget {
  const DispenserIngredientsUI({super.key, required this.index_});

  final int index_;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      maxSimultaneousDrags: 1,
      data: index_,

      feedback: SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Image.asset(
            ingrediantSettings[index_ + 1],
            fit: BoxFit.contain,
          )
    ),

      childWhenDragging: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.black87),
          ),
          child: Center(
            child: Text(
              dispenserIngredients[index_],
              style: TextStyle(
                color: Colors.black87,
                fontSize: MediaQuery.of(context).size.height * 0.01,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
      ),

      child: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            //border: Border.all(color: Colors.black87),
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
            child: Text(
              dispenserIngredients[index_],
              style: TextStyle(
                color: Colors.black87,
                fontSize: MediaQuery.of(context).size.height * 0.01,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
    );
  }
}


///Widget for the Ingrediants that got dragged into the field
class SandwichIngrediants extends StatelessWidget {
  const SandwichIngrediants({super.key, required this.index_, required this.indexList, required this.function});

  //Index for recognizing what dispenser is meant with the number
  final int index_;
  //Index in the newSandwich-List
  final int indexList;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        function(indexList);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Image.asset(
              ingrediantSettings[index_ + 1],
              fit: BoxFit.contain,
            ),
      ),
    );
  }
}