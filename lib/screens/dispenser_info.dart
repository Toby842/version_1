//Import Flutter libraries:
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

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
      backgroundColor: Colors.white,
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
              height: MediaQuery.of(context).size.height * 0.528,
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

            Container(
              height: MediaQuery.of(context).size.height * 0.001,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.black87,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.303,
              width: MediaQuery.of(context).size.width * 0.85,
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DispenserContent(number: 1,),
                  DispenserContent(number: 2,),
                  DispenserContent(number: 3,),
                  DispenserContent(number: 4,),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            )

        ],
      ),
    );
  }
}




///Widget for the content of the dispenser
class DispenserContent extends StatefulWidget {
  const DispenserContent({super.key, required this.number});

  final int number;

  @override
  State<DispenserContent> createState() => _DispenserContentState();
}

class _DispenserContentState extends State<DispenserContent> {

  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }


  void changeIngrediant() {
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
                    Text(
                      "What´s in the Dispenser:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

                    TextField(
                      controller: _textEditingController,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_textEditingController.text != '') {
                              dispenserIngredients[widget.number - 1] = _textEditingController.text;
                            } else {
                              dispenserIngredients[widget.number - 1] = 'Empty';
                            }
                            setState(() {});
                            Navigator.of(context).pop();
                          }, 
                          child: const Text('save')
                        )
                      ],
                    )
                  ]
              );
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.303,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.black87)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                width: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  child: FittedBox(
                    child: Text(
                      "Dispenser ${widget.number}:",
                      style: const TextStyle(
                          color: Colors.black87,
                      ),
                    ),
                  )),
                ],
              ),

              Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: TextButton(
                    style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                    onPressed: () {changeIngrediant();},
                    child: FittedBox(
                      child: Text(
                        dispenserIngredients[widget.number - 1],
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const Spacer()
            ],
          ),
        ),

      ),
    );
  }
}