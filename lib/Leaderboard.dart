import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/LeaderboardCard.dart';
import 'package:sdd_assignment_2/MainMenu.dart';
import 'package:sdd_assignment_2/Player.dart';
import 'LeaderboardCard.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _Leaderboard();
}

class _Leaderboard extends State<LeaderBoard> {
  var selectedTab = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        centerTitle: true,
        flexibleSpace: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.close),
                color: colours.AppColor.main,
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(
                flex: 5,
              ),
              Text(
                'LEADERBOARD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'StickNoBills',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(
                flex: 5,
              ),
              Visibility(
                child: IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.close),
                  color: colours.AppColor.main,
                  onPressed: () => Navigator.pop(context),
                ),
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                visible: false,
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.07,
            MediaQuery.of(context).size.height * 0.03,
            MediaQuery.of(context).size.width * 0.07,
            MediaQuery.of(context).size.height * 0.04),
        child: Center(
            child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colours.AppColor.buttonBackground,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedTab = 1;
                          });
                        },
                        style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 23.0, right: 23.0),
                            backgroundColor: selectedTab == 1
                                ? colours.AppColor.main
                                : colours.AppColor.buttonBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(
                                    color: Colors.transparent, width: 0))),
                        child: Text("Easy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: selectedTab == 1
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'StickNoBills')),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedTab = 2;
                          });
                        },
                        style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 23.0, right: 23.0),
                            backgroundColor: selectedTab == 2
                                ? colours.AppColor.main
                                : colours.AppColor.buttonBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                side: BorderSide(
                                    color: Colors.transparent, width: 0))),
                        /*
                        style: ButtonStyle(
                            backgroundColor: selectedTab == 2
                                ? MaterialStateProperty.all<Color>(
                                    colours.AppColor.main)
                                : MaterialStateProperty.all<Color>(
                                    colours.AppColor.buttonBackground),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.transparent, width: 0)))),

                         */
                        child: Text("Medium",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: selectedTab == 2
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'StickNoBills')),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedTab = 3;
                          });
                        },
                        style: TextButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 23.0, right: 23.0),
                            backgroundColor: selectedTab == 3
                                ? colours.AppColor.main
                                : colours.AppColor.buttonBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                side: BorderSide(
                                    color: Colors.transparent, width: 0))),
                        /*
                        style: ButtonStyle(
                            backgroundColor: selectedTab == 3
                                ? MaterialStateProperty.all<Color>(
                                    colours.AppColor.main)
                                : MaterialStateProperty.all<Color>(
                                    colours.AppColor.buttonBackground),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.transparent, width: 0)))),

                         */
                        child: Text("Hard",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: selectedTab == 3
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'StickNoBills')),
                      ),
                    ]),
              ),
              Container(
                //margin: const EdgeInsets.fromLTRB(18.0, 10, 20, 2),
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Position",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'StickNoBills'),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'StickNoBills'),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Points",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'StickNoBills'),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
              FutureBuilder(
                  future: getTopTenEasy(selectedTab),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data;
                    }

                    return Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        )),
      )),
    );
  }

  Future<Widget> getTopTenEasy(int selectedTab) async {
    var playerList = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('players').get();
    List<Widget> widgetList = [];
    List<Widget> leaderboardCards = [];

    String firebaseChild = "";

    if (snapshot.exists) {
      if (selectedTab == 1) {
        firebaseChild = "highestScore_easy";
      }
      if (selectedTab == 2) {
        firebaseChild = "highestScore_medium";
      }
      if (selectedTab == 3) {
        firebaseChild = "highestScore_hard";
      }
      for (var item in snapshot.children) {
        if (item.child("${firebaseChild}").value != null) {
          var playerName = item.child("name").value;
          var playerHighScore = item.child("${firebaseChild}").value;
          Player player = Player.fromPlayer(playerName, playerHighScore);
          playerList.add(player);
          print(playerName);
          print(playerHighScore);
        }
        // Player player = Player.fromJson(item.value);
        // player.deserializeMap();
        // playerList.add(player);
      }
      playerList.sort(((a, b) => b.highScore.compareTo(a.highScore)));

      for (int i = 0; i < playerList.length; i++) {
        leaderboardCards.add(returnLeaderboardCard(playerList[i], i + 1));
        if (i + 1 == 10) {
          break;
        }
      }

      return Expanded(
        child: ListView(
          children: leaderboardCards,
        ),
      );
    } else {
      print('No data available.');
    }
    return Text("No data available.");
  }

  returnLeaderboardCard(Player player, int position) {
    String positionText = "";
    if (position == 1) {
      positionText = position.toString() + "st";
    } else if (position == 2) {
      positionText = position.toString() + "nd";
    } else if (position == 3) {
      positionText = position.toString() + "rd";
    } else {
      positionText = position.toString() + "th";
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
      height: 60,
      decoration: BoxDecoration(
        color: colours.AppColor.buttonBackground,
        border: Border.all(
          color: colours.AppColor.main,
          width: 3.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "${positionText}",
          style: TextStyle(
            color: colours.AppColor.main,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'StickNoBills',
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "${player.name}", //Replace with player.name
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'StickNoBills'),
          textAlign: TextAlign.center,
        ),
        Center(
          child: Text(
            "${player.highScore}", //Replace with player.points
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontFamily: 'StickNoBills'),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
