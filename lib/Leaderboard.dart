import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/LeaderboardCard.dart';
import 'package:sdd_assignment_2/Player.dart';
import 'LeaderboardCard.dart';
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
            MediaQuery.of(context).size.height * 0.025,
            MediaQuery.of(context).size.width * 0.07,
            MediaQuery.of(context).size.height * 0.05),
        child: Center(
            child: Container(
          child: Column(
            children: [
              Container(
                //margin: const EdgeInsets.fromLTRB(18.0, 10, 20, 2),
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
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
                  future: getTopTen(),
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

  Future<Widget> getTopTen() async {
    List<Player> playerList = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('players').get();
    List<Widget> widgetList = [];

    if (snapshot.exists) {
      for (var item in snapshot.children) {
        print(item.value);
        Player player = Player.fromJson(item.value);
        player.deserializeMap();
        playerList.add(player);
      }
      playerList.sort(((a, b) => b.point.compareTo(a.point)));

      List<Widget> leaderboardCards = [];

      for (int i = 0; i < playerList.length; i++) {
        leaderboardCards.add(returnLeaderboardCard(playerList[i], i + 1));
      }

      return Expanded(
        child: ListView(
          children: leaderboardCards,
        ),
      );
    } else {
      print('No data available.');
    }
    return Text("FUCK"); //Ayo???? Who did this
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
        Text(
          "${player.point}", //Replace with player.points
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontFamily: 'StickNoBills'),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
