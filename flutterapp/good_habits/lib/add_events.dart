import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:good_habits/globalFunctions.dart';
import 'package:good_habits/globalValues.dart';
import 'package:good_habits/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage/Cards.dart';

TextEditingController nameText = TextEditingController();
TextEditingController goalText = TextEditingController();

class AddEvents extends StatelessWidget {
  const AddEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/background_2.png",
            width: double.infinity,
            opacity: const AlwaysStoppedAnimation(1),
          ),
          AddEventsStful(),
        ],
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //       Color(0xffF5F4FF),
      //       Color(0xffF5F5FE),
      //     ]),
      //   ),
      //   child: AddEventsStful(),
      // ),
    );
  }
}

class AddEventsStful extends StatefulWidget {
  const AddEventsStful({super.key});

  @override
  State<AddEventsStful> createState() => _AddEventsStfulState();
}

class _AddEventsStfulState extends State<AddEventsStful> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedIconIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const myText(
                  text: "Event Details",
                  size: 30,
                  isbold: true,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/cancel.png",
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const myText(
                  text: "Name",
                  size: 20,
                  isbold: true,
                ),
                Stack(
                  children: [
                    // Positioned(
                    //   height: 45,
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    //     child: Container(
                    //       color: Colors.black.withOpacity(1),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      width: double.infinity,
                      child: TextFormField(
                        controller: nameText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                  text: "Icon",
                  size: 20,
                  isbold: true,
                ),
                Stack(
                  children: [
                    // Positioned(
                    //   height: 45,
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    //     child: Container(
                    //       color: Colors.black.withOpacity(1),
                    //     ),
                    //   ),
                    // ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FutureBuilder(
                          future: getAllIconsFromAssets(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return IconsGenerate(snapshot: snapshot);
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            }
                          },
                        )),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                  text: "Goal",
                  size: 20,
                  isbold: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: goalText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Count",
                        ),
                      ),
                    ),
                    Text(
                      " / Day",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),

                // Stack(
                //   children: [
                //     // Positioned(
                //     //   height: 45,
                //     //   child: BackdropFilter(
                //     //     filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                //     //     child: Container(
                //     //       color: Colors.black.withOpacity(1),
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // )
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () async {
              if (isValidInputs) {}

              // allCardsDetails = [];
              allCardsDetails!.add(CardBonesStructure(nameText.text,
                  iconAddress, 0, int.parse(goalText.text), DateTime.now()));
              print("allCardsDetails:$allCardsDetails");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('savedCards', jsonEncode(allCardsDetails));

              Navigator.pop(context);
            },
            child: Opacity(
              opacity: isValidInputs ? 1 : 0.6,
              child: Container(
                width: 280,
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0xff4E82EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: myText(
                    text: "Save",
                    size: 24,
                    color: Colors.white,
                    isbold: true,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

int selectedIconIndex = -1;
bool isValidInputs = false;

class IconsGenerate extends StatefulWidget {
  const IconsGenerate({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  State<IconsGenerate> createState() => _IconsGenerateState();
}

String? iconAddress;

class _IconsGenerateState extends State<IconsGenerate> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 3,
      children: [
        ...List.generate(widget.snapshot.data!.length, (index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  iconAddress = widget.snapshot.data[index];
                  selectedIconIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedIconIndex == index
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  widget.snapshot.data![index],
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

Future<List<String>> getAllIconsFromAssets(context) async {
  var assetsFile =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(assetsFile);
  List<String> listMp3 = manifestMap.keys
      .where(
          (String key) => key.contains('assets/icons/') && key.endsWith(".png"))
      .toList();
  // print(listMp3);
  // await Future.delayed(Duration(seconds: 3), () {
  //   print("done");
  // });

  return listMp3;
}
