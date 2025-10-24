import 'screans/profilepage.dart';
import 'package:flutter/material.dart';
import 'screans/homepage.dart';
import 'widget/buttonnavbar.dart';
import 'screans/settings.dart';

class Mainscrean extends StatefulWidget {
  const Mainscrean({super.key});

  @override
  State<Mainscrean> createState() => _MainscreanState();
}

class _MainscreanState extends State<Mainscrean> {
  int _selectedIndex = 0;

  void navigationbar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Profilepage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Buttonnavbar(onTapChange: (index) => navigationbar(index)),
      ),
    );
  }
}
