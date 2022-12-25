import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sdd_assignment_2/MainMenu.dart';
import 'Firebase_Services.dart';
import 'colours.dart' as colours;

class Signup extends StatefulWidget{
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();

}

class _SignupState extends State<Signup>{
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colours.AppColor.background,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.05,
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.01),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset("assets/images/App_logo.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/images/App_name.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                    //fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        returnUsername(),
                        returnPassword(),
                        returnName(),
                        submit(context),
                        const SizedBox(height: 10),
                        login(context),
                      ],
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }
  Widget returnUsername(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5.0, top: 15.0),
          child: const Text(
            "Email:",
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
          margin: const EdgeInsets.only(top: 12.0),
          child: TextFormField(
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'StickNoBills',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            validator: (value) {
              String regex =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(regex);

              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              if(!regExp.hasMatch(value)){
                return 'Enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                filled: true,
                fillColor: colours.AppColor.buttonBackground,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                //labelText: 'Player Name',
                labelStyle: const TextStyle(
                  fontFamily: 'StickNoBills',
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget returnPassword(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5.0, top: 12.0),
          child: const Text(
            "Password:",
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
          margin: const EdgeInsets.only(top: 12.0),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'StickNoBills',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                filled: true,
                fillColor: colours.AppColor.buttonBackground,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                //labelText: 'Player Name',
                labelStyle: const TextStyle(
                  fontFamily: 'StickNoBills',
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget returnName(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5.0, top: 12.0),
          child: const Text(
            "Username:",
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
          margin: const EdgeInsets.only(top: 12.0),
          child: TextFormField(
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'StickNoBills',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                filled: true,
                fillColor: colours.AppColor.buttonBackground,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.error,
                      width: 3,
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: colours.AppColor.main,
                      width: 3,
                    )
                ),
                //labelText: 'Player Name',
                labelStyle: const TextStyle(
                  fontFamily: 'StickNoBills',
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget submit(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () async {
            if(formKey.currentState!.validate()){
              String email = _emailController.text;
              String pass = _passwordController.text;
              String username = _nameController.text;
              try {
                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: pass,
                ).then((_) {
                  // user exist
                  //Navigator.popUntil(context, (route) => route.isFirst);
                });
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.transparent)
                  )
              ),
              backgroundColor:
              MaterialStateProperty.all<Color>(colours.AppColor.main),
              side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
          child: const Text(
              "Sign up",
              style: TextStyle(
                fontFamily: 'StickNoBills',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )
          ),
        ),
      ),
    );
  }

  Widget login(BuildContext context){
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: Colors.white70),
          ),
          TextSpan(
            text: 'Login here',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }
}

