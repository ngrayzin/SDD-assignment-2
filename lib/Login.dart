import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdd_assignment_2/MainMenu.dart';
import 'Firebase_Services.dart';
import 'Player.dart';
import 'Signup.dart';
import 'colours.dart' as colours;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login>{
  @override
  void initState() {
    super.initState();
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    if (currentUser != null) {
      print(currentUser.uid);
      print("fuck");
    }
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool isLoading1 = false;

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
                        returnEmail(),
                        returnPassword(),
                        submit(),
                        const SizedBox(height: 10),
                        signUp(),
                        const SizedBox(height: 10),
                        or(),
                        const SizedBox(height: 10),
                        googleSignIn()
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
            controller: email,
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
            controller: password,
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
  Widget submit(){
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
              String mail = email.text;
              String pass = password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: mail,
                    password: pass,
                ).then((credential) async {
                  print(credential.user?.uid);
                  print(credential.user?.displayName);
                  formKey.currentState?.reset();
                  setState(() {
                    isLoading = false;
                  });
                  DatabaseReference newPlayer = FirebaseDatabase.instance.ref('players/${credential.user?.uid}');
                  await newPlayer.update({
                    "name": credential.user?.displayName,
                  }).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  const MainMenu()), (Route<dynamic> route) => false));
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
          child:!isLoading? const Text(
            "Login",
            style: TextStyle(
            fontFamily: 'StickNoBills',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
          ): Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget googleSignIn(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton.icon(
        icon: Image.asset("assets/images/google.png",width: 32,height: 32,fit: BoxFit.cover,),
        onPressed: () async {
          setState(() {
            isLoading1 = true;
          });
          //FirebaseService service = FirebaseService();
          final GoogleSignIn googleSignIn = GoogleSignIn();
          try {
            final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
            final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
            await FirebaseAuth.instance.signInWithCredential(credential)
              .then((value) async {
                final user = value.user;
                print(user?.uid);
                setState(() {
                  isLoading1 = false;
                });
                DatabaseReference newPlayer = FirebaseDatabase.instance.ref('players/${user?.uid}');
                await newPlayer.update({
                  "name": user?.displayName,
                }).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const MainMenu()), (Route<dynamic> route) => false));
            });
          } on FirebaseAuthException catch (e) {
            setState(() {
              isLoading1 = false;
            });
            print(e.message);
            throw e;
          }
        },
        label: !isLoading1? Text(
          "Sign in with google",
          style: TextStyle(
              color: colours.AppColor.background, fontWeight: FontWeight.bold),
        ): Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.transparent)
                )
            ),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
            side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
      ),
    );
  }

  Widget signUp(){
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: Colors.white70),
          ),
          TextSpan(
            text: 'Sign up here',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return const Signup();
                    }));
              },
          ),
        ],
      ),
    );
  }
}

Widget or(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Expanded(
        child: Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
          color: Colors.white70,
        ),
      ),
      Text(
        "OR",
        style: TextStyle(color: Colors.white70),
      ),
      Expanded(
        child: Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
          color: Colors.white70,
        ),
      ),
    ],
  );
}



