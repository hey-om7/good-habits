import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:good_habits/globalFunctions.dart';
import 'package:good_habits/globalValues.dart';

class ExtraOptionCards extends StatelessWidget {
  const ExtraOptionCards(
      {super.key,
      required this.name,
      required this.iconAddress,
      required this.index});
  final String name;
  final String iconAddress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: GestureDetector(
          onTap: () async {
            _showBottomSheet(context, index);

            // _modalBottomSheetMenu(context);
          },
          child: Stack(
            children: [
              Blur(
                colorOpacity: 0.2,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 85,
                  // width: 40,
                ),
              ),
              Container(
                height: 85,
                // width: 40,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "$iconAddress",
                        color: Colors.white,
                        width: 35,
                        height: 35,
                      ),
                      myText(
                        text: "$name",
                        size: 15,
                        isbold: true,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: myText(
                      text: "Add Value",
                      size: 35,
                      isbold: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 244,
                        decoration: BoxDecoration(
                          color: Color(0xffD8E5FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Image.asset(
                        "assets/add.png",
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      //TODO:
                      allCardsDetails![index].currentCount =
                          (allCardsDetails![index].currentCount ?? 0) + 1;
                      print(allCardsDetails![index].currentCount);
                      saveTheDataFromList(allCardsDetails!);

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Color(0xff4E82EA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: myText(
                          text: "Add",
                          size: 25,
                          isbold: true,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _modalBottomSheetMenu(context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Center(
                child: new Text("This is a modal sheet"),
              )),
        );
      });
}
