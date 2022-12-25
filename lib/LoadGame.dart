import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'package:sdd_assignment_2/BuildingCard.dart';
import 'package:sdd_assignment_2/GameBoard.dart';
import 'Building.dart';
import 'GamePage.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/src/widgets/container.dart';

class LoadGame extends StatefulWidget {
  const LoadGame({super.key});
  @override
  State<LoadGame> createState() => _LoadGameState();
  static Player player = Player("name", [], 0);
  static int num1 = 0;
  static int num2 = 0;
  static int row = 10;
  static int col = 10;
}

class _LoadGameState extends State<LoadGame> {
  final BoardSettings boardSettings =
      BoardSettings(cols: GamePage.col, rows: GamePage.row);
  final TextEditingController myController = TextEditingController();
  bool found = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Load Game Page',
        home: Scaffold(
          backgroundColor: colours.AppColor.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            centerTitle: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.12),
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
                    'LOAD GAME',
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
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.07,
                  MediaQuery.of(context).size.height * 0.05,
                  MediaQuery.of(context).size.width * 0.07,
                  MediaQuery.of(context).size.height * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Enter Your Name Below:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'StickNoBills',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0),
                      child: TextField(
                        controller: myController,
                        onChanged: (text) {
                          getPlayerData(text).then((value) {
                            if (value.isEmpty == false) {
                              LoadGame.player = value[0];
                              found = true;
                            } else {
                              found = false;
                            }
                          });
                          // if (getPlayerData(text) != Text('No')) {
                          //   debugPrint('hel');
                          // }
                          // ;
                        },
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'StickNoBills',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                25.0, 18.0, 25.0, 15.0),
                            filled: true,
                            fillColor: colours.AppColor.buttonBackground,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: colours.AppColor.main,
                                  width: 3,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: colours.AppColor.main,
                                  width: 3,
                                )),
                            //labelText: 'Player Name',
                            labelStyle: TextStyle(
                              fontFamily: 'StickNoBills',
                              color: Colors.grey,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 5.0),
                      child: Text(
                        "Recent Game Played:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'StickNoBills',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      //previous game card

                      margin: EdgeInsets.only(top: 12.0),
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      //height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: colours.AppColor.buttonBackground,
                        border: Border.all(
                          width: 3.0,
                          color: colours.AppColor.main,
                        ),
                      ),

                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: found == true
                                ? returnGameBoard()
                                : const Text(''),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Row(
                            //game details (points + turns + money)
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                  elevation: 0,
                                  shadowColor: null,
                                  color: colours.AppColor.main,
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            'assets/images/Point.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          SizedBox(width: 12.0),
                                          Text(
                                            found == true
                                                ? LoadGame.player.point
                                                    .toString()
                                                : '0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'StickNoBills',
                                              color:
                                                  colours.AppColor.background,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Card(
                                  elevation: 0,
                                  shadowColor: null,
                                  color: colours.AppColor.main,
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 12.0),
                                          Text(
                                            found == true
                                                ? 'TURN  ${LoadGame.player.turn}'
                                                : 'TURN  0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'StickNoBills',
                                              color:
                                                  colours.AppColor.background,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Card(
                                  elevation: 0,
                                  shadowColor: null,
                                  color: colours.AppColor.main,
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            'assets/images/Coin.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          SizedBox(width: 12.0),
                                          Text(
                                            found == true
                                                ? LoadGame.player.coin
                                                    .toString()
                                                : '0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'StickNoBills',
                                              color:
                                                  colours.AppColor.background,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colours.AppColor.main,
                            ),
                            onPressed: () {
                              GamePage.player = LoadGame.player;
                              GamePage.loaded = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GamePage(),
                                ),
                              );
                            },
                            child: Text(
                              'Load the game',
                              style: TextStyle(
                                fontFamily: 'StickNoBills',
                                color: colours.AppColor.background,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<List<Player>> getPlayerData(String name) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('players').get();
    List<Player> playerList = [];
    for (var item in snapshot.children) {
      Player player = Player.fromJson(item.value);
      player.deserializeMap();
      if (player.name == name) {
        playerList.add(player);
        return playerList;
      }
    }
    return playerList;
  }

  Widget returnGameBoard() {
    //Would be nice if you could clean up this code
    //It is just copied over from gamepage. Same goes for the widgets below
    return Expanded(
      //margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 400,
          child: GridView.count(
            crossAxisCount: boardSettings.cols,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: [
              for (var i = 0; i < boardSettings.totalTiles(); i++)
                returnBoardTile(i)
            ],
          ),
        ),
      ),
    );
  }

  Widget returnBoardTile(int index) {
    bool exist = false;
    String name = "";
    List<String> building = [
      'Park',
      'Industry',
      'Residential',
      'Road',
      'Commercial'
    ];
    return DragTarget<Building>(
      onAccept: (data) => setState(() {
        exist = LoadGame.player.turn == 0
            ? true
            : rules(LoadGame.player.map, index);
        name = data.name;
        exist ? LoadGame.player.addItemToMap(index, name) : null;
        exist ? LoadGame.player.addTurn() : null;
        exist ? LoadGame.player.minusCoin() : null;
        exist ? LoadGame.player.calculatePoints(GamePage.row) : null;
        //print(LoadGame.player.map);
      }),
      builder: (context, accept, reject) {
        if (exist) {
          return returnBuildingTile(name);
        } else {
          if (building.contains(LoadGame.player.map[index])) {
            return returnBuildingTile(LoadGame.player.map[index]);
          } else {
            LoadGame.player.addItemToMap(index, "-");
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              //child: Center(child: Text ("${widget.boardIndex}"),),
            );
          }
        }
      },
    );
  }

  Widget returnBuildingTile(String name) {
    return Container(
        color: BuildingCard.returnColour(name),
        child: Center(
          child: Image.asset('assets/images/$name.png'),
        ));
  }
}
