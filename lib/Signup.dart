import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sdd_assignment_2/MainMenu.dart';
import 'package:sdd_assignment_2/Player.dart';
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  'SIGN UP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'StickNoBills',
                    fontWeight: FontWeight.bold,
                    color: colours.AppColor.main,
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0,
              MediaQuery.of(context).size.width * 0.07,
              MediaQuery.of(context).size.height * 0.01),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        returnName(),
                        returnEmail(),
                        returnPassword(),
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
  Widget returnEmail(){
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
            controller: _emailController,
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
            controller: _passwordController,
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
            controller: _nameController,
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
              setState(() {
                isLoading = true;
              });
              String email = _emailController.text;
              String pass = _passwordController.text;
              String username = _nameController.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: pass,
                ).then((credential) {
                  final user = credential.user;
                  print(user?.uid);
                  Player player = Player(username, [], 0);
                  FirebaseDatabase.instance
                      .ref('players/${user?.uid}')
                      .set(player.toJson())
                      .then((_) {
                    // Data saved successfully!
                    setState(() {
                      isLoading = false;
                    });
                    formKey.currentState?.reset();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        const MainMenu()), (Route<dynamic> route) => false);
                      }).catchError((error) {
                        setState(() {
                          isLoading = false;
                        });
                        print(error);
                        // The write failed...
                      });
                    // user exist
                  //Navigator.popUntil(context, (route) => route.isFirst);
                });
              } on FirebaseAuthException catch (e) {
                setState(() {
                  isLoading = false;
                });
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            }
            //const CircularProgressIndicator();
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
          child: !isLoading? const Text(
              "Sign up",
              style: TextStyle(
                fontFamily: 'StickNoBills',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )
          ): Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          )
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

