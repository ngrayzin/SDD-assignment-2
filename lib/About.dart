import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'firebase_options.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "About Page",
      home: Scaffold(
        backgroundColor: colours.AppColor.background,
        appBar: AppBar (
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: colours.AppColor.background,
          centerTitle: true,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.12),
            child : Row(
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
                  'ABOUT N.A.C',
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
                    icon: const Icon(Icons.info_outline),
                    color: colours.AppColor.main,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(), //goes to about page
                          ));
                    },
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
            padding:  EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width*0.07,
                MediaQuery.of(context).size.height*0.05,
                MediaQuery.of(context).size.width*0.07,
                MediaQuery.of(context).size.height*0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const SizedBox(height: 5.0),
                  Container(
                    // Container for Description
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: const TextSpan(
                        text: "DESCRIPTION:\n",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'StickNoBills',
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'The player is the mayor of Ngee Ann City, and the goal of the game is to build the happiest and most prosperous city possible, i.e., score the most points.\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'This city-building game begins with 16 coins. In each turn, the player will construct one of two randomly-selected buildings in the 10x10 city. Each construction cost 1 coin. For the first building, the player can build anywhere in the city. For subsequent constructions, the player can only build on squares that are connected to existing buildings. The other building that was not built is discarded.\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'Each building scores in a different way. The objective of the game is to build a city that scores as many points as possible.\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    // Container for BUILDINGS title
                    child: const Text(
                      "BUILDINGS:",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              color: colours.AppColor.roadColor,
                              child: Image.asset('assets/images/Road.png'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Road",
                            style: TextStyle(
                                color: Color(0xFFFFFC00),
                                fontSize: 38,
                                fontFamily: 'StickNoBills',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              color: const Color.fromARGB(255, 0, 255, 255),
                              child: Image.asset('assets/images/Residential.png'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Residential",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 255, 255),
                                fontSize: 38,
                                fontFamily: 'StickNoBills',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              color: const Color.fromARGB(255, 255, 162, 0),
                              child: Image.asset('assets/images/Commercial.png'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Commercial",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 162, 0),
                                fontSize: 38,
                                fontFamily: 'StickNoBills',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              color: const Color.fromARGB(255, 0, 255, 94),
                              child: Image.asset('assets/images/Park.png'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Park",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 255, 94),
                                fontSize: 38,
                                fontFamily: 'StickNoBills',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              color: const Color.fromARGB(255, 204, 0, 255),
                              child: Image.asset('assets/images/Industry.png'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Industry",
                            style: TextStyle(
                                color: Color.fromARGB(255, 204, 0, 255),
                                fontSize: 38,
                                fontFamily: 'StickNoBills',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    //margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: const TextSpan(
                        text: "Points System:\n",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'StickNoBills',
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Road (*): ',

                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFFFC00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            ' Scores 1 point per connected road (*) in the same row\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Residential (R): ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'If it is next to an industry (I), then it scores 1 point only. Otherwise, it scores 1 point for each adjacent residential (R) or commercial (C), and 2 points for each adjacent park (O).\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Commercial (C): ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 162, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'Scores 1 point per commercial adjacent to it. Each commercial generates 1 coin per residential adjacent to it\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Park (O): ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 255, 94),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Scores 1 point per park adjacent to it.\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text: 'Industry (I): ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 204, 0, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(height: 35)),
                          TextSpan(
                            text:
                            'Scores 1 point per industry in the city. Each industry generates 1 coin per residentialbuilding adjacent to it\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}