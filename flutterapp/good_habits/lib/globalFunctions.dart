import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage/Cards.dart';
import 'homepage/homepage.dart';

class myText extends StatelessWidget {
  const myText(
      {required this.text, this.color, required this.size, this.isbold});
  final String text;
  final Color? color;
  final double size;
  final bool? isbold;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontWeight: isbold == null ? FontWeight.normal : FontWeight.bold,
        color: color ?? Colors.black,
        fontSize: size,
      ),
    );
  }
}

int calcStreaks(DateTime dateSaved) {
  var date2 = DateTime.now();
  int difference = date2.difference(dateSaved).inDays;
  return difference;
}

Future<void> saveTheDataFromList(List<CardBonesStructure> theListPassed) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('savedCards', jsonEncode(theListPassed));
}

Future<List<CardBonesStructure>> getAllSavedCards() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? peopleJson = prefs.getString('savedCards');
  if (peopleJson == null) {
    return [];
  }
  List<dynamic> peopleList = jsonDecode(peopleJson);
  return peopleList.map((e) => CardBonesStructure.fromJson(e)).toList();
}
