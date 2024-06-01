import 'package:aplikasikpu/models/database.dart';
import 'package:aplikasikpu/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() async {
  //connect db
  final database = MyDatabase();

  //print data
  final allPersons = await database.getAllPersons();
  print(allPersons);

  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  final MyDatabase database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: HomePage(database: database),
      ),
    );
  }
}
