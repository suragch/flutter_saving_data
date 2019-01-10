import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_saving_data/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving data'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Read'),
              onPressed: () {
                _read();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _save();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Shared preferences

//  _read() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'my_int_key';
//    final value = prefs.getInt(key) ?? 0;
//    print('read: $value');
//  }
//
//  _save() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'my_int_key';
//    final value = 42;
//    prefs.setInt(key, value);
//    print('saved: $value');
//  }

  // Database

  _read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${word.word} ${word.frequency}');
    }
  }

  _save() async {
    Word word = Word();
    word.word = 'hello';
    word.frequency = 15;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
  }

  // File

//  _read() async {
//    try {
//      final directory = await getApplicationDocumentsDirectory();
//      final file = File('${directory.path}/amy_file.txt');
//      String text = await file.readAsString();
//      file.writeAsBytes()
//      print(text);
//    } catch (e) {
//      print("Couldn't read file");
//    }
//  }
//
//  _save() async {
//    final directory = await getApplicationDocumentsDirectory();
//    final file = File('${directory.path}/amy_file.txt');
//    final text = 'Hello World!';
//    await file.writeAsString(text);
//    print('saved');
//  }
}
