import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdd_assignment_2/About.dart';
import 'package:sdd_assignment_2/GameLevel.dart';
import 'package:sdd_assignment_2/GamePage.dart';
import 'package:sdd_assignment_2/LoadGame.dart';
import 'package:sdd_assignment_2/PopUpMessage.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import "Leaderboard.dart";
import 'package:audioplayers/audioplayers.dart';
import "Profile.dart";

/*final GoogleSignIn _googleSignIn = GoogleSignIn(
  signInOption: SignInOption.games,
  scopes: ['email'],
);*/

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
  static int value = 0;
}

class _MainMenuState extends State<MainMenu> {
  //AudioPlayer audioPlayer = AudioPlayer();
  bool menu = true;
  late bool _isButtonDisabled;
  var list = [];
  late Player player;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    //returnSaveGame();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  void dispose() {
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //loadSound();
    //audioPlayer.resume();
    WidgetsBinding.instance.addPostFrameCallback((_) => returnSaveGame());
    return Scaffold(
        backgroundColor: colours.AppColor.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.05,
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  width: 300,
                  child: Image.asset("assets/images/App_logo_2.png"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.only(top: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text:
                  TextSpan(
                      text: "N",
                      style: const TextStyle(
                        fontSize: 58,
                        color: Colors.white,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.w900,
                      ),
                      // Player's Email Address goes here
                      children: [
                        TextSpan(
                          text: 'GEE.',
                          style: TextStyle(
                              fontSize: 58,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.w900,
                              color: colours.AppColor.main),
                        ),
                        const TextSpan(
                          text: "A",
                          style: TextStyle(
                            fontSize: 58,
                            color: Colors.white,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: 'NN.',
                          style: TextStyle(
                              fontSize: 58,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.w900,
                              color: colours.AppColor.main),
                        ),
                        const TextSpan(
                          text: "C",
                          style: TextStyle(
                            fontSize: 58,
                            color: Colors.white,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: 'ITY',
                          style: TextStyle(
                              fontSize: 58,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.w900,
                              color: colours.AppColor.main),
                        ),
                      ]),
                ),
              ),
              // hello
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const GameLevel();
                  })),
                  style: ElevatedButton.styleFrom(
                    primary: colours.AppColor.main, //background color of button
                    side: const BorderSide(width:0, color:Colors.black), //border width and color
                    elevation: 2, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(15)
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 15, 5, 12), //content padding inside button
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("NEW GAME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 32,
                          color: Colors.black,
                          fontFamily: 'StickNoBills',
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ]
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              !isLoading? Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: ElevatedButton(
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
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoadGame(
                                    player: player,
                                    coin: list[0],
                                    level: list[1],
                                    point: list[3],
                                  );
                                }));
                              },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.restart_alt,
                                size: 50,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text("CONTINUE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 32,
                                      color: Colors.black,
                                      fontFamily: 'StickNoBills',
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: 10.0,
              ),

              //ROW     ROW      ROW      ROW      ROW      ROW      ROW
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //padding: const EdgeInsets.only(top: 8, bottom: 8),
                      //width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () {
                          var currentUser = FirebaseAuth.instance.currentUser;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ProfilePage(currentUser: currentUser);
                              }));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colours.AppColor.main, //background color of button
                          side: const BorderSide(width:0, color:Colors.black), //border width and color
                          elevation: 2, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(15.0), //content padding inside button
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.black,
                              ),
                            ]
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      //padding: const EdgeInsets.only(top: 8, bottom: 8),
                      //width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const LeaderBoard();
                            })),
                        style: ElevatedButton.styleFrom(
                          primary: colours.AppColor.main, //background color of button
                          side: const BorderSide(width:0, color:Colors.black), //border width and color
                          elevation: 2, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(15.0), //content padding inside button
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.leaderboard,
                                size: 50,
                                color: Colors.black,
                              ),
                            ]
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    /*
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //width: MediaQuery.of(context).size.width * 0.65,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const GameLevel();
                      })),
                      style: ElevatedButton.styleFrom(
                        primary:
                            colours.AppColor.main, //background color of button
                        side: const BorderSide(
                            width: 0,
                            color: Colors.black), //border width and color
                        elevation: 2, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(
                            12, 14, 12, 12), //content padding inside button
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 50,
                              color: Colors.black,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),

                   */
                    Container(
                      //padding: const EdgeInsets.only(top: 8, bottom: 8),
                      //width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => PopUpMessage(
                              value: MainMenu.value,
                            )),
                        style: ElevatedButton.styleFrom(
                          primary: colours.AppColor.main, //background color of button
                          side: const BorderSide(width:0, color:Colors.black), //border width and color
                          elevation: 2, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(15.0), //content padding inside button
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.exit_to_app,
                                size: 50,
                                color: Colors.black,
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void returnSaveGame() async {
    //late bool check;
    //list = [];
    final ref = FirebaseDatabase.instance.ref();
    var currentUser = FirebaseAuth.instance.currentUser;
    /*Future.delayed(const Duration(milliseconds: 1500),() async {

    });*/
    await ref
        .child('players/${currentUser?.uid}/saveGame')
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        list = [];
        for (var item in snapshot.children) {
          //print(item.value);
          list.add(item.value);
        }
        player = Player(currentUser?.displayName, [], list[4], list[0]);
        player.stringMap = list[2];
        player.deserializeMap();
        _isButtonDisabled = false;
        setState(() {
          list;
          player;
          isLoading = false;
        });
        //check = false;
      } else {
        _isButtonDisabled = true;
        setState(() {
          isLoading = false;
        });
        //check = true;
      }
    });
    //return check;
  }

/*  void loadSound() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    final player = AudioCache(prefix: 'assets/audio/');
    final url = await player.load('mainSong.mp3');
    audioPlayer.setSourceUrl(url.path);
  }*/
}
