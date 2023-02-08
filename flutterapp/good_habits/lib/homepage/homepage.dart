import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:good_habits/add_events.dart';
import 'package:good_habits/globalValues.dart';
import 'package:good_habits/homepage/weekProgress.dart';

import '../globalFunctions.dart';
import 'Cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        // primarySwatch: Colors.teal,
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePageStful(),
    );
  }
}

class HomePageStful extends StatefulWidget {
  const HomePageStful({super.key});

  @override
  State<HomePageStful> createState() => _HomePageStfulState();
}

class _HomePageStfulState extends State<HomePageStful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Image.asset(
            "assets/add.png",
            width: 50,
          ),
          onPressed: () async {
            final result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddEvents()));
            if (result == null) {
              setState(() {});
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Align(
            child: Image.asset(
              "assets/background.png",
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FutureBuilder(
                future: getAllSavedCards(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    allCardsDetails = snapshot.data;

                    return ListView(
                      children: [
                        WeekProgress(),
                        SizedBox(
                          height: 20,
                        ),
                        ...List.generate(snapshot.data!.length, (index) {
                          return Cards(
                            name: snapshot.data![index].name.toString(),
                            streakday: calcStreaks(
                                snapshot.data![index].registeredDate!),
                            currentVal:
                                snapshot.data![index].currentCount!.toInt(),
                            totalVal: snapshot.data![index].totalCount!.toInt(),
                            iconAddress:
                                snapshot.data![index].iconAddress.toString(),
                            index: index,
                          );
                        }),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
