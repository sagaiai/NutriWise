import 'package:flutter/material.dart';
import "package:google_nav_bar/google_nav_bar.dart";

class Buttonnavbar extends StatelessWidget {
  void Function(int)? onTapChange;
  Buttonnavbar({super.key, required this.onTapChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color(0xFFf3f7fa),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.white,
        iconSize: 38,
        tabActiveBorder: Border.all(color: Color(0xFF40211f)),
        tabBackgroundColor: Color(0xFF40211f),
        tabBorderRadius: 70,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        onTabChange: (value) => onTapChange!(value),
        tabs: [
          GButton(icon: Icons.home),
          GButton(icon: Icons.person),
          GButton(icon: Icons.settings_outlined),
        ],
      ),
    );
  }
}
