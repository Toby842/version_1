// @dart=2.9

// Flutter Libraries that are imported in this file are listed here:
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

// Other Files of this Project that are imported in this file are listed here:
import 'package:version_1/screens/anchor.dart';
import 'package:version_1/globals.dart';

//======================================================================
//This is the main function of the whole App.
//The App runs through this function first, that means all data needs to be fetched here (stored data, etc.)
//======================================================================


void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandi SM-1200',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      ///there is an argument required!!!
      //home: const Anchor(),
      home: const Foundation(),
    );
  }
}   


class Foundation extends StatefulWidget {
  const Foundation({Key key}) : super(key: key);

  @override
  State<Foundation> createState() => _FoundationState();
}

class _FoundationState extends State<Foundation> {

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => prepareInformation());
  }

  prepareInformation() async {
    Database database = await openDatabase('sandiSM1200.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE sandiSM1200 (id INTEGER PRIMARY KEY, aMap TEXT, key1 TEXT)'
      );
    });

    ///check if database is already setup
    int count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM sandiSM1200'));
    if (count == 0 || count == null) {
      await database.transaction((txn) async {

        ///setup language
        const String languageTemplate = 'English';
        final String jsonlanguageTemplate = json.encode(languageTemplate);
        await txn.insert(
          'sandiSM1200', {'aMap': jsonlanguageTemplate, 'key1': "languageSettings"}
        );

        ///setup favourites (just the names)
        Map<String, dynamic> favouritesBase = {};
        final String jsonFavouritesBase = json.encode(favouritesBase);
        await txn.insert(
          'sandiSM1200', {'aMap': jsonFavouritesBase, 'key1': "favouritesStored"}
        );

        ///setup dispenserIngredients
        Map<String, dynamic> dispenserIngredientsBase = {
          "0": "Brot",
          "1": "Leer",
          "2": "Leer",
          "3": "Leer",
          "4": "Leer",
        };
        final String  jsonDispenserIngredients = json.encode(dispenserIngredientsBase);
        await txn.insert(
          'sandiSM1200', {'aMap': jsonDispenserIngredients, 'key1': "dispenserIngredientsStored"}
        );

        ///setup ingredient Image Settings
        Map<String, dynamic> ingrediantSettingsBase = {
          "1": "assets/ingredients/bread.png",
          "2": "assets/ingredients/mayo.png",
          "3": "assets/ingredients/ketchup.png",
          "4": "assets/ingredients/tomaten.png",
          "5": "assets/ingredients/lochkas.png",
        };
        final String jsonIngredientSettings = json.encode(ingrediantSettingsBase);
        await txn.insert(
          'sandiSM1200', {'aMap': jsonIngredientSettings, 'key1': "ingredientSettingsStored"}
        );

        ///setup fillstand
        Map<String, dynamic> fillStandBase = {
          "1": 0,
          "2": 0,
          "3": 0,
          "4": 0,
          "5": 0,
        };
        final String jsonFillStand = json.encode(fillStandBase);
        await txn.insert(
          'sandiSM1200', {'aMap': jsonFillStand, 'key1': "fillStandStored"}
        );

        ///setup favourites Zutaten
        await txn.rawInsert(
          'INSERT INTO sandiSM1200(aMap, key1) VALUES("{}", "favouritesIngredientsStored")'
        );

      });
    } else {}

    debugPrint('database exists or was created');


    ///load globals from database
    List<dynamic> dataList = await database.rawQuery('SELECT * FROM sandiSM1200');
    language = json.decode(dataList[0]['aMap']);
    favourites = json.decode(dataList[1]['aMap']);
    dispenserIngredients = json.decode(dataList[2]['aMap']);
    ingrediantSettings = json.decode(dataList[3]['aMap']);
    fillStand = json.decode(dataList[4]['aMap']);
    favouritesData = json.decode(dataList[5]['aMap']);

    isLoaded = true;
    debugPrint('everything loaded');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoaded = false) 
      ? const Center(
        child: Text('Preparing Information...'),
      )
      : const Anchor()
    );
  }
}
