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
import 'colours.dart' as colours;
import 'firebase_options.dart';
import 'dart:developer';

class PopUpMessage extends StatefulWidget {
  const PopUpMessage({super.key});
  @override
  State<PopUpMessage> createState() => _PopUpMessage();

}

class _PopUpMessage extends State<PopUpMessage>{
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          title: const Text(
            'EXIT GAME?',
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
              onPressed: () => SystemNavigator.pop(),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    const Size(80, 50)),
                padding: MaterialStateProperty.all<
                    EdgeInsets>(
                    const EdgeInsets.all(5)),
                foregroundColor:
                MaterialStateProperty.all<Color>(
                    colours
                        .AppColor.buttonBackground),
                backgroundColor:
                MaterialStateProperty.all<Color>(
                    colours.AppColor.main),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.0)),
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
                    Navigator.pop(context, 'NO'),
                style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all(
                      const Size(80, 20)),
                  padding: MaterialStateProperty.all<
                      EdgeInsets>(
                      const EdgeInsets.all(5)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(
                      colours.AppColor
                          .buttonBackground),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      colours.AppColor.main),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            10.0)),
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
  }
}