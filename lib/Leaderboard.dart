import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/LeaderboardCard.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

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
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding:  EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width*0.07,
                  MediaQuery.of(context).size.height*0.025,
                  MediaQuery.of(context).size.width*0.07,
                  MediaQuery.of(context).size.height*0.05),
              child: Column(
                children: [
                  Container(
                    //margin: const EdgeInsets.fromLTRB(18.0, 10, 20, 2),
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                  ), //Container for Leaderboard Title
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                  LeaderboardCard(),
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}
