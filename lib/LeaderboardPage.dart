import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame/flame.dart'; // ADDED FLAME INTO DART FILE
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // ADDED GOOGLE FONTS
import 'colours.dart' as colours;
import 'Firebase_options.dart';
import 'LeaderBoardCard.dart';
import 'Player.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPage();
}

class _LeaderBoardPage extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: colours.AppColor.background,
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "LEADERBOARD",
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'StickNoBills',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          iconSize: 40,
          icon: const Icon(Icons.close),
          color: colours.AppColor.main,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(18.0, 10, 20, 2),
            padding: const EdgeInsets.all(5.0),
            color: colours.AppColor.background,
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: 10, //Replace with list size from database read
              itemBuilder: (BuildContext context, int index) {
                return LeaderBoardCard();
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // backgroundColor: colours.AppColor.background,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(40),
      //   child: AppBar(
      //     automaticallyImplyLeading: false,
      //     elevation: 0,
      //     backgroundColor: Colors.transparent,
      //     bottomOpacity: 0,
      //     centerTitle: true,
      //     flexibleSpace: Padding(
      //       padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const Spacer(
      //             flex: 1,
      //           ),
      //           IconButton(
      //             iconSize: 40,
      //             icon: const Icon(Icons.close),
      //             color: colours.AppColor.main,
      //             onPressed: () => Navigator.pop(context),
      //           ),
      //           const Spacer(
      //             flex: 5,
      //           ),
      //           Text(
      //             'LEADERBOARD',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 40,
      //               fontFamily: 'StickNoBills',
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           ),
      //           const Spacer(
      //             flex: 5,
      //           ),
      //           Visibility(
      //             child: IconButton(
      //               iconSize: 40,
      //               icon: const Icon(Icons.close),
      //               color: colours.AppColor.main,
      //               onPressed: () => Navigator.pop(context),
      //             ),
      //             maintainAnimation: true,
      //             maintainSize: true,
      //             maintainState: true,
      //             visible: false,
      //           ),
      //           const Spacer(
      //             flex: 1,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
//       body: Center(
//           child: Column(
//         children: [
//           // Call database and pull in data
//           // Implement for loop here to read data and populate container
          // Container(
          //   margin: const EdgeInsets.fromLTRB(18.0, 10, 20, 2),
          //   padding: const EdgeInsets.all(5.0),
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(15)),
          //   ),
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text(
          //           "Position",
          //           style: TextStyle(
          //               fontSize: 24,
          //               color: Colors.white,
          //               fontFamily: 'StickNoBills'),
          //           textAlign: TextAlign.center,
          //         ),
          //         Text(
          //           "Name",
          //           style: TextStyle(
          //               fontSize: 24,
          //               color: Colors.white,
          //               fontFamily: 'StickNoBills'),
          //           textAlign: TextAlign.center,
          //         ),
          //         Text(
          //           "Points",
          //           style: TextStyle(
          //               fontSize: 24,
          //               color: Colors.white,
          //               fontFamily: 'StickNoBills'),
          //           textAlign: TextAlign.center,
          //         ),
          //       ]),
          // ),
//           LeaderBoardCard() 
//         ],
//       )),
//     );
//   }
// }
