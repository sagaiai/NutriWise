import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/row.dart';
import '../servise/apigemini.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final model = Apigemini();
  final TextEditingController _textController = TextEditingController();

  final List<Map<String, String>> _itemsList = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _saveitme() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = jsonEncode(_itemsList);
    await prefs.setString('items_list', itemsJson);
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('items_list');

    if (itemsJson != null) {
      final decoded = jsonDecode(itemsJson);

      if (decoded is List) {
        setState(() {
          _itemsList.clear();
          _itemsList.addAll(
            decoded.map<Map<String, String>>((item) {
              final map = Map<String, String>.from(
                (item as Map).map(
                  (key, value) => MapEntry(key.toString(), value.toString()),
                ),
              );
              return map;
            }).toList(),
          );
        });
      }
    }
  }

  Future<void> _addItem(String itemName) async {
    setState(() {
      _itemsList.insert(0, {'name': itemName, 'calories': 'loading...'});
    });

    try {
      final responseText = await model.sendpromtTogemnini(itemName);
      final newCalories = responseText ?? 'غير متوفر';

      setState(() {
        _itemsList[0]['calories'] = newCalories;
      });
    } catch (e) {
      setState(() {
        _itemsList[0]['calories'] = 'خطأ';
      });
    }

    await _saveitme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFafca83),
          image: DecorationImage(
            image: AssetImage("assets/image7.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "HOME",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),

            Spacer(),
            Container(
              width: double.infinity,
              height: 380,
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
              child: Padding(
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                  itemCount: _itemsList.length,
                  itemBuilder: (buildContext, index) {
                    final item = _itemsList[index];
                    return Rowcart(
                      name: item['name']!,
                      calories: item['calories']!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              final Color primaryColor = Color(0xFF6BC015);
              final Color accentColor = Color(0xFF6BC015);
              final Color textColor = Color(0xFF6BC015);
              final Color hintColor = Color(0xFF6BC015);

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                title: Text(
                  "Add Food Item",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ), // that is becous this is emulator it is not real phone
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'e.g., apple, banana, orange',
                        hintStyle: TextStyle(color: hintColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      cursorColor: accentColor,
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        final itemName = _textController.text.trim();
                        if (itemName.isNotEmpty) {
                          _addItem(itemName);
                          _textController.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Save Item",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

                actionsPadding: const EdgeInsets.only(bottom: 15.0),
              );
            },
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFF40211f),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: const Center(child: Icon(Icons.add, color: Colors.white)),
        ),
      ),
    );
  }
}
