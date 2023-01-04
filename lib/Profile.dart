import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdd_assignment_2/Firebase_Services.dart';
import 'package:sdd_assignment_2/Login.dart';
import 'package:sdd_assignment_2/main.dart';
import 'colours.dart' as colours;
import 'firebase_options.dart';
import 'MainMenu.dart';
import 'Firebase_Services.dart';

//var currentUser = FirebaseAuth.instance.currentUser;

bool isLoading = true;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.currentUser});
  final User? currentUser;

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
              EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.12),
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
              const Text(
                'PROFILE',
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
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                visible: false,
                child: IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.close),
                  color: colours.AppColor.main,
                  onPressed: () => Navigator.pop(context),
                ),
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
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: 240,
                        child: Image.asset("assets/images/Profile.png"),
                      ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '${currentUser?.displayName}',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.bold,
                          ), // Player Name goes here
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          size: 20,
                          color: colours.AppColor.main,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${currentUser?.email}',
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Colors.white,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.normal,
                            ),
                            // Player's Email Address goes here
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                          color: Colors.white,
                        ),
                    const SizedBox(height: 30),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Your Completed Games",
                        style: TextStyle(
                          fontSize: 25,
                          color: colours.AppColor.main,
                          fontFamily: 'StickNoBills',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                        future: getGamesPlayed(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          }

                          return Column(
                            children: [
                              Text(
                                "Data not found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: colours.AppColor.main,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "GAME(S)",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.normal,
                          ),
                        )
                    ),

                    /*
                    FutureBuilder(
                        future: getGamesPlayed(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          }

                          return Column(
                            children: [
                              Text(
                                "GAMES FINISHED",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: colours.AppColor.main,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }),

                     */
                    const SizedBox(height: 30),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Your High Scores",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'StickNoBills',
                        color: colours.AppColor.main,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(by level)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'StickNoBills',
                        letterSpacing: 1,
                        color: colours.AppColor.main,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: getHighestScoreEasy(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data;
                                }
                                return Column(
                                  children: [
                                    const Text(
                                      "EASY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'StickNoBills',
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              }),
                          const SizedBox(height: 30),
                          FutureBuilder(
                              future: getHighestScoreMedium(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data;
                                }
                                return Column(
                                  children: [
                                    const Text(
                                      "MEDIUM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'StickNoBills',
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              }),
                          const SizedBox(height: 40),
                          FutureBuilder(
                              future: getHighestScoreHard(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data;
                                }
                                return Column(
                                  children: [
                                    const Text(
                                      "HARD",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'StickNoBills',
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),


                    /*
                    FutureBuilder(
                        future: getHighestScoreEasy(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          }
                          return Column(
                            children: [
                              const Text(
                                "EASY LEVEL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(height: 30),
                    FutureBuilder(
                        future: getHighestScoreMedium(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          }
                          return Column(
                            children: [
                              const Text(
                                "MEDIUM LEVEL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(height: 40),
                    FutureBuilder(
                        future: getHighestScoreHard(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          }
                          return Column(
                            children: [
                              const Text(
                                "HARD LEVEL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'StickNoBills',
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator(),
                              ),
                            ],
                          );
                        }),

                     */
                    // Log Out Button
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      //width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(currentUser?.providerData.any((UserInfo info) => info.providerId == "google.com") == true){
                            await GoogleSignIn().signOut().then((value){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              const Login()), (Route<dynamic> route) => false);
                            });
                          }
                          else{
                            await FirebaseAuth.instance.signOut().then((value){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              const Login()), (Route<dynamic> route) => false);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colours
                              .AppColor.main, //background color of button
                          side: const BorderSide(
                              width: 0,
                              color: Colors.black), //border width and color
                          elevation: 2, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.fromLTRB(
                              0, 15, 5, 12), //content padding inside button
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 15.0,
                              ),
                              Text("LOG OUT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 32,
                                      color: Colors.black,
                                      fontFamily: 'StickNoBills',
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<Widget> getGamesPlayed () async {
    var list = [];
    int i = 0;
    final gamesPlayed = FirebaseDatabase.instance.ref().child('players/${currentUser?.uid}/finishGame');
    await gamesPlayed.get().then((snapshot) {
      if(snapshot.exists){
        for(var item in snapshot.children){
          list.add(item);
        }
        i = list.length;
      }
    });
    return RichText(
      textAlign: TextAlign.center,
      text:
          /*
      TextSpan(
        text: "GAMES FINISHED\n",
        style: TextStyle(
          fontSize: 30,
          color: colours.AppColor.main,
          fontFamily: 'StickNoBills',
          fontWeight: FontWeight.bold,
        ),
        // Player's Email Address goes here
        children: [
          const WidgetSpan(child: SizedBox(height: 35)),

           */
          TextSpan(
            text: '$i',
            style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
    );
  }

  Future<Widget> getHighestScoreEasy() async {
    final ref = FirebaseDatabase.instance.ref().child('players/${currentUser?.uid}/highestScore_easy');
    int score = 0;
    await ref.get().then((snapshot) {
      if(snapshot.exists){
        String string = snapshot.value.toString();
        int i = int.parse(string);
        score = i;
      }
    });
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '$score\n',
          style: const TextStyle(
            fontSize: 55,
            color: Colors.white,
            fontFamily: 'StickNoBills',
            fontWeight: FontWeight.bold,
          ),
          // Probably insert the grid here?
          children: const [
            WidgetSpan(child: SizedBox(height: 10)),
            TextSpan(
              text: "EASY",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ]),
    );
  }

  Future<Widget> getHighestScoreMedium() async {
    final ref = FirebaseDatabase.instance.ref().child('players/${currentUser?.uid}/highestScore_medium');
    int score = 0;
    await ref.get().then((snapshot) {
      if(snapshot.exists){
        String string = snapshot.value.toString();
        int i = int.parse(string);
        score = i;
      }
    });
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '$score\n',
          style: const TextStyle(
            fontSize: 55,
            color: Colors.white,
            fontFamily: 'StickNoBills',
            fontWeight: FontWeight.bold,
          ),
          // Probably insert the grid here?
          children: const [
            WidgetSpan(child: SizedBox(height: 10)),
            TextSpan(
              text: "MEDIUM",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ]),
    );
  }

  Future<Widget> getHighestScoreHard() async {
    final ref = FirebaseDatabase.instance.ref().child('players/${currentUser?.uid}/highestScore_hard');
    int score = 0;
    await ref.get().then((snapshot) {
      if(snapshot.exists){
        String string = snapshot.value.toString();
        int i = int.parse(string);
        score = i;
      }
    });
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '$score\n',
          style: const TextStyle(
            fontSize: 55,
            color: Colors.white,
            fontFamily: 'StickNoBills',
            fontWeight: FontWeight.bold,
          ),
          // Probably insert the grid here?
          children: const [
            WidgetSpan(child: SizedBox(height: 10)),
            TextSpan(
              text: "HARD",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ]),
    );
  }

}
