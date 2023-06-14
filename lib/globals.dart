//At this file all global variables are stored. 
//I would recommend to sort them according to their typ (int, string, etc)

library version_1.globals;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

//Strings======================================================================
///string for selected time
String prepareIn = '0030';

String language = 'English';

///string for fillstands of sauce-dispensers. Just for working with it
///they don´t have to be stored.
String fillStandSauce1 = '00';
String fillStandSauce2 = '00';

//Integers=====================================================================


//Boolians=====================================================================
///checks if all images for the dispenser-rotation-animation are loaded into
///imageList (the list that is mentioned under Lists)
bool imagePrecached = false;

///checks if a bluetooth-scan was already started
bool startedScanning = false;

///checks if a bluetooth device is connected
bool isConnected = false;



//Lists========================================================================
///this must stored
List<String> favourites = ['Salami', 'Käse'];

///this is where names are stored. The user setts the names except bread
///this must be stored
List<String> dispenserIngredients = ['Brot', 'Leer', 'Leer', 'Leer', 'Leer'];

///this is the list where all the images for the dispenser-rotation-animation
///are stored. the user has no access to this list. The list is loaded when the
///app starts in the anchor widget
List<ImageProvider> imageList = [];

///Here the indexes of the dispensers are stored in the order the user drags
///the ingredients into the drop-area. in the end this list holds the order
///of dispensers where the ingredients are located for the sandwich
List<int> newSandwich = [];

///This list holds all paths for all available images the user can select from
List<String> imageLibrary = [
  'assets/ingredients/toast.png',
  'assets/ingredients/sauce1.png',
  'assets/ingredients/tomato.png',
  'assets/ingredients/cheese.png',
  'assets/ingredients/ketchup.png',
  'assets/ingredients/mayo.png',
];

//Maps=========================================================================
///This map holds the current image for each dispenser that the user selected
///This must be stored
Map<int, dynamic> ingrediantSettings = {
  1: 'assets/ingredients/toast.png',
  2: 'assets/ingredients/mayo.png',
  3: 'assets/ingredients/ketchup.png',
  4: 'assets/ingredients/tomato.png',
  5: 'assets/ingredients/cheese.png',
};

///this map stores the current fill-level for each dispenser
///this must be stored
Map<int, dynamic> fillStand = {
  ///Dispenser one is meassured in pieces (BREAD)
  1: 0,
  ///Dispenser two is meassured in millilitres (SAUCE)
  2: 0,
  ///Dispenser 3 is meassured in millilitres (SAUCE)
  3: 0,
  ///Dispenser four - i have no idea how this is meassured (SLICER)
  4: 0,
  ///Dispenser five is meassured in pieces (CHEESE)
  5: 0,
};

///copy for keeping fillstand up to date while creating a sandwich
Map<int, dynamic> fillStandCopy = {};

///this map holds the refference values for the fill-levels in String-format and int-format
Map<int, dynamic> fillRefference = {
  ///Dispenser one is meassured in pieces (BREAD)
  1: '1 pieces',
  11: 6,
  ///Dispenser two is meassured in millilitres (SAUCE)
  2: '300 ml',
  22: 300,
  ///Dispenser three is meassured in millilitres (SAUCE)
  3: '300 ml',
  33: 300,
  ///Dispenser three - i have no idea how this is meassured (SLICER)
  4: '1 pieces',
  44: 1,
  ///Dispenser four is meassured in pieces (CHEESE)
  5: '6 pieces',
  55: 6 ,
};

Map<int, dynamic> typeTranslations = {
  1: 'Bread',
  11: 'Brot',

  2: 'Sauce1',
  22: 'Soße1',

  3: 'Sauce2',
  33: 'Soße2',

  4: 'Slicer',
  44: 'Schneide',

  5: 'Cheese',
  55: 'Käse',
};

///Map for favourite sandwiches
Map<String, dynamic> favouritesData = {
  'Salami': [0, 1, 3, 1, 0],
  'Käse': [0, 2, 1, 0, 3, 2, 0],
};


//Keys=========================================================================


//Undefined====================================================================
late BluetoothDevice connectedDeviceGlobal;
late BluetoothCharacteristic characteristicGloabl;