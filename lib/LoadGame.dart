import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'package:sdd_assignment_2/BoardSettings.dart';
import 'About.dart';
import 'Building.dart';
import 'EndGame.dart';
import 'GamePage.dart';
import 'Player.dart';
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:audioplayers/audioplayers.dart';

class LoadGame extends StatefulWidget {
  final Player player;
  final int coin;
  final int level;
  final int point;
  const LoadGame(
      {super.key,
      required this.player,
      required this.coin,
      required this.level,
      required this.point});

  @override
  State<LoadGame> createState() => _LoadGameState();

  static int num1 = 0;
  static int num2 = 0;
  static int row = 0;
}

class _LoadGameState extends State<LoadGame> {
  AudioPlayer audioPlayer = AudioPlayer();
  late BoardSettings boardSettings =
      BoardSettings(cols: widget.level, rows: widget.level);

  @override
  void initState() {
    super.initState();
    widget.player.level = widget.level;
    widget.player.coin = widget.coin;
    widget.player.point = widget.point;
    LoadGame.num1 = GamePage.randomNum();
    LoadGame.num2 = GamePage.randomNum();
    LoadGame.row = widget.player.level;

    if (widget.player.coin <= 0 || widget.player.endGrid() == true) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EndGame(widget.player), //goes to about page
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
          title: 'Load Previous Game',
          home: Scaffold(
            backgroundColor: colours.AppColor.background,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: colours.AppColor.background,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.15), // was 0.12
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return saveGameMsg();
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    const Text(
                      'N.A.C',
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
                          print("hello");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AboutPage(), //goes to about page
                          ));
                        },
                      ),
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,
                      visible: true,
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
                  height: MediaQuery.of(context).size.height,
                  //alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.07,
                      MediaQuery.of(context).size.height * 0.03, //was 0.05
                      MediaQuery.of(context).size.width * 0.07,
                      MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.buttonBackground,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/Point.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${widget.player.point}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          Card(
                            elevation: 0,
                            shadowColor: null,
                            color: colours.AppColor.buttonBackground,
                            child: SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'TURN  ${widget.player.turn}',
                                      style: const TextStyle(
                                        fontFamily: 'StickNoBills',
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Card(
                              elevation: 0,
                              shadowColor: null,
                              color: colours.AppColor.buttonBackground,
                              child: SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/Coin.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        '${widget.player.coin}',
                                        style: const TextStyle(
                                          fontFamily: 'StickNoBills',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
                      returnGameBoard(),

                      //SizedBox(height: 20.0),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: IntrinsicHeight(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //randomizer here
                              randomizer(LoadGame.num1),
                              // BuildingCard(),
                              const Spacer(),
                              // BuildingCard(),
                              randomizer(LoadGame.num2),
                            ],
                          )))
                    ],
                  )),
            ),
          )),
    );
  }

  AlertDialog saveGameMsg() {
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: const Text(
        'SAVE GAME?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 50,
          fontFamily: 'StickNoBills',
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: MediaQuery.of(context).size.width),
          borderRadius: BorderRadius.circular(12)),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            FirebaseDatabase.instance
                .ref('players/${currentUser?.uid}/saveGame')
                .set(widget.player.ToJson())
                .then((_) {
              // Data saved successfully!
              Navigator.popUntil(context, (route) => route.isFirst);
            }).catchError((error) {
              print(error);
              // The write failed...
            });
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(80, 50)),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
            foregroundColor: MaterialStateProperty.all<Color>(
                colours.AppColor.buttonBackground),
            backgroundColor:
                MaterialStateProperty.all<Color>(colours.AppColor.main),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          child: const Text('YES',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'StickNoBills',
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 25),
        TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(80, 20)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(5)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  colours.AppColor.buttonBackground),
              backgroundColor:
                  MaterialStateProperty.all<Color>(colours.AppColor.main),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            child: const Text('NO',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.only(bottom: 85)),
      ],
    );
    return alert;
  }

  Widget randomizer(int number) {
    Building building = Building(number);
    return Draggable<Building>(
      data: building,
      feedback: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Card(
              color: colours.AppColor.background,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Image.asset('assets/images/${building.name}.png'),
                ),
              )),
        ),
      ),
      childWhenDragging: const SizedBox(
        width: 20,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.37,
        height: MediaQuery.of(context).size.width * 0.37,
        child: Card(
            elevation: 8,
            shadowColor: colours.AppColor.main,
            color: colours.AppColor.buttonBackground,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colours.AppColor.main, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/${building.name}.png'),
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      building.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'StickNoBills',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget returnGameBoard() {
    return Expanded(
      //margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
          height: 350,
          child: GridView.count(
            //padding: EdgeInsets.zero,
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

  void loadSound() async {
    final player = AudioCache(prefix: 'assets/audio/');
    final url = await player.load('lego.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  Widget returnBoardTile(int index) {
    loadSound();
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
        exist =
            widget.player.turn == 0 ? true : rules(widget.player.map, index);
        name = data.name;
        exist ? audioPlayer.resume() : null;
        exist ? widget.player.addItemToMap(index, name) : null;
        exist ? widget.player.addTurn() : null;
        exist ? widget.player.minusCoin() : null;
        exist ? widget.player.calculatePoints(LoadGame.row) : null;
        if (widget.player.coin == 0 || widget.player.endGrid() == true) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                EndGame(widget.player), //goes to end game page
          ));
        }
        if (exist) {
          LoadGame.num1 = GamePage.randomNum();
          LoadGame.num2 = GamePage.randomNum();
          // Loop to check if it is the same value, change if it's same value
          while (LoadGame.num1 == LoadGame.num2) {
            LoadGame.num1 = GamePage.randomNum();
          }
        }
        //print(GamePage.player.map);
      }),
      builder: (context, accept, reject) {
        if (exist) {
          return returnBuildingTile(name);
        } else {
          if (building.contains(widget.player.map[index])) {
            return returnBuildingTile(widget.player.map[index]);
          } else {
            widget.player.addItemToMap(index, "-");
            return Container(
              decoration: BoxDecoration(
                color: colours.AppColor.main,
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
        color: colours.AppColor.background,
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Image.asset('assets/images/$name.png'),
            )));
  }

  bool rules(List<String> map, int i) {
    List<String> building = [
      'Park',
      'Industry',
      'Residential',
      'Road',
      'Commercial'
    ];
    //center index is either +1 -1 +10 -10
    if (building.contains(map[i])) {
      return false;
    } else if (map.asMap().containsKey(i - LoadGame.row) &&
        map[i - LoadGame.row] != "-") {
      //check if there is smt below
      return true;
    } else if (map.asMap().containsKey(i + LoadGame.row) &&
        map[i + LoadGame.row] != "-") {
      //check if there is smt on top
      return true;
    } else if (map.asMap().containsKey(i - 1) &&
        map[i - 1] != "-" &&
        i % LoadGame.row != 0) {
      //check if there is smt on the left
      return true;
    } else if (map.asMap().containsKey(i + 1) &&
        map[i + 1] != "-" &&
        (i + 1) % LoadGame.row != 0) {
      //check if there is smt on the right
      return true;
    } else {
      return false;
    }
  }
}
