import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'firebase_options.dart';
import 'MainMenu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                MediaQuery.of(context).size.height * 0.05,
                MediaQuery.of(context).size.width * 0.07,
                MediaQuery.of(context).size.height * 0.05),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "NAME:\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: colours.AppColor.main,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.bold,
                          ),
                          // Player Name goes here
                          children: [
                            const WidgetSpan(child: SizedBox(height: 35)),
                            const TextSpan(
                              text: 'Player',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "EMAIL:\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: colours.AppColor.main,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.bold,
                          ),
                          // Player's Email Address goes here
                          children: [
                            const WidgetSpan(child: SizedBox(height: 35)),
                            const TextSpan(
                              text: 'player24808@gmail.com',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "HIGHEST SCORE:\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: colours.AppColor.main,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.bold,
                          ),
                          // Player's Highest Score goes here
                          children: [
                            const WidgetSpan(child: SizedBox(height: 35)),
                            const TextSpan(
                              text: '350',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "GAMES PLAYED:\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: colours.AppColor.main,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.bold,
                          ),
                          // Player's Email Address goes here
                          children: [
                            const WidgetSpan(child: SizedBox(height: 35)),
                            const TextSpan(
                              text: '6',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //Difficulty
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "EASY LEVEL:\n",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.bold,
                            ),
                            // Probably insert the grid here?
                            children: [
                              WidgetSpan(child: SizedBox(height: 10)),
                              TextSpan(
                                text: 'Locked',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "MEDIUM LEVEL:\n",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.bold,
                            ),
                            // Probably insert the grid here?
                            children: [
                              WidgetSpan(child: SizedBox(height: 10)),
                              TextSpan(
                                text: 'Locked',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: "HARD LEVEL:\n",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'StickNoBills',
                              fontWeight: FontWeight.bold,
                            ),
                            // Probably insert the grid here?
                            children: [
                              WidgetSpan(child: SizedBox(height: 10)),
                              TextSpan(
                                text: 'Locked',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                    // Log Out Button
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MainMenu();
                        })),
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
}
