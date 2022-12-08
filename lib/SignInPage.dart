import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colours.dart' as colours;

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours.AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: colours.AppColor.main,
          iconSize: 40, //Change to be responsive
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Text(
              "ENTER NAME TO SAVE GAME!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 232, 154),
                fontSize: 48,
                fontFamily: 'StickNoBills',
                fontWeight: FontWeight.bold,
              ), //For the colour,
            ),
          ),
          const Align(
            //Makes the "Text go left
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                "Player Name:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'StickNoBills',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 54, 232, 154), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 54, 232, 154), width: 3),
                  ),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold,
                  )),
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {}, //Button that says Confirm
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 54, 232, 154),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'StickNoBills',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
