import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginpage.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Future<void> signOutUser() async {
      await FirebaseAuth.instance.signOut();
    }

    final displayName = user?.displayName ?? "nameuser";
    final email = user?.email ?? "no email";
    final photoUrl = user?.photoURL;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image6.png"),
          fit: BoxFit.cover,
        ),
      ),

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 35),
                Text(
                  "PROFILE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                IconButton(
                  onPressed: () async {
                    await signOutUser();
                    // After signing out, navigate the user to the login or welcome screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loginpage(),
                      ), // Replace with your login screen
                    );
                  },
                  icon: Icon(Icons.output_rounded),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: photoUrl != null
                    ? NetworkImage(photoUrl)
                    : AssetImage('assets/default_user.png') as ImageProvider,
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  if (user == null)
                    Text(
                      "data nathin",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        Cards(
                          name: "gemini-2.5-flash",
                          image: "assets/icons8-gemini-ai-100.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
