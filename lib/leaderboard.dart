import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'firebase_options.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('N.A.C\'s'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: const Text(
              "LeaderBoard",
              textAlign: TextAlign.center,
            ),
          ), //Container for leaderboard title
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10, 10, 2),
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player Position"),
                  const Text("Player Name"),
                  const Text("Player Score"),
                ]),
          ), //Container for Leaderboard Title
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2, 5, 2),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 5.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player Position"),
                  const Text("Player Name"),
                  const Text("Player Score"),
                ]),
          ), //Container for player leaderboard attributes
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2, 5, 2),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 5.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player Position"),
                  const Text("Player Name"),
                  const Text("Player Score"),
                ]),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2, 5, 2),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 5.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Player Position"),
                  const Text("Player Name"),
                  const Text("Player Score"),
                ]),
          )
        ],
      )),
    );
  }
}
