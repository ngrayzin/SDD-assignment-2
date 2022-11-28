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
        title: const Text('N.A.C\'s\''),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 37.74, 10, 3),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Title Player Position"),
                  const Text("Title Player Name"),
                  const Text("Title Player Score"),
                ]),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
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
