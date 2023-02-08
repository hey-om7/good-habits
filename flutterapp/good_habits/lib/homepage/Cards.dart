import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../globalFunctions.dart';
import 'ExtraOptionCards.dart';

class Cards extends StatelessWidget {
  Cards({
    required this.name,
    required this.streakday,
    required this.currentVal,
    required this.totalVal,
    required this.iconAddress,
    required this.index,
  });
  final String name;
  final int streakday;
  final int currentVal;
  final int totalVal;
  final String iconAddress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          ExtraOptionCards(
            name: "Add",
            iconAddress: "assets/add.png",
            index: index,
          ),
          ExtraOptionCards(
            name: "Edit",
            iconAddress: "assets/edit.png",
            index: index,
          ),
          ExtraOptionCards(
            name: "Reset",
            iconAddress: "assets/reset.png",
            index: index,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              height: 90,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  color: Colors.black.withOpacity(1),
                ),
              ),
            ),
            Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.2),
                //     blurRadius: 5,
                //     spreadRadius: 2,
                //   ),
                // ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "$iconAddress",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        myText(
                          text: name,
                          size: 22,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/fire.png",
                                  width: 18,
                                ),
                                Text(
                                  "$streakday",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "$currentVal/$totalVal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1, 3),
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBonesStructure {
  String? name;
  String? iconAddress;
  int? currentCount;
  int? totalCount;
  DateTime? registeredDate;
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconAddress': iconAddress,
      'currentCount': currentCount,
      'totalCount': totalCount,
      'registeredDate': registeredDate!.toIso8601String(),
      // 'registeredDate': registeredDate.toString(),
    };
  }

  static CardBonesStructure fromJson(val) {
    return CardBonesStructure(
      val["name"],
      val["iconAddress"],
      val["currentCount"],
      val["totalCount"],
      DateTime.parse(val["registeredDate"]),
    );
  }

  CardBonesStructure(this.name, this.iconAddress, this.currentCount,
      this.totalCount, this.registeredDate);
}
