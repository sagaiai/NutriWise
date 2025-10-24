import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galores_ai_application/mainscrean.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  Future<UserCredential?> singinwithgoogel() async {
    try {
      final GoogleSignInAccount? googleusers = await GoogleSignIn().signIn();
      if (googleusers == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleusers.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF92d4f4),
        image: DecorationImage(
          image: AssetImage("assets/image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Startup with login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    inherit: false,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's start this app",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    inherit: false,
                  ),
                ),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () async {
                    UserCredential? usercredantial = await singinwithgoogel();
                    if (usercredantial != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Mainscrean()),
                      );
                    } else {
                      print("Google Sign-In failed.");
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 12),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            inherit: false,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
