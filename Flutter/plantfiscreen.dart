// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlantScreen extends StatefulWidget {
  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  bool value = false;
  final dbRef = FirebaseDatabase.instance.reference();
  final scrollImages = ['assets/MonsteraLogo.png', 'assets/ZZlogo.png'];

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: dbRef.child("HackProj").onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Container(
                      color: Colors.green[800],
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.clear_all,
                          ),
                          Text(
                            "Plantfi",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.settings)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 300.0,
                    height: 40,
                    child: TextField(
                        autofocus: true,
                        cursorColor: Colors.green[700],
                        style: TextStyle(height: 1.5),
                        textAlignVertical: TextAlignVertical.bottom,
                        maxLines: 1,
                        maxLength: 100,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Plant Name Here",
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                )))),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image(
                              image: AssetImage('assets/plants/ZZlogo.png'),
                              height: 300,
                              width: 400),
                          Image(
                              image:
                                  AssetImage('assets/plants/MonsteraLogo.png'),
                              height: 300,
                              width: 400),
                          Image(
                              image: AssetImage(
                                  'assets/plants/RubberTreeLogo.png'),
                              height: 300,
                              width: 400),
                        ],
                      )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Moisture Content",
                              style: TextStyle(
                                  color:
                                      value ? Colors.green[800] : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data!.snapshot.value["Moisture"]
                                      .toString() +
                                  " %", //insert firebase here
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      onUpdate();
                    },
                    label: value ? Text("On") : Text("Off"),
                    elevation: 10,
                    backgroundColor: value ? Colors.green[800] : Colors.white,
                    icon: value
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text("View Moisture History"),
                      backgroundColor: Colors.lightGreenAccent,
                      icon: Icon(Icons.auto_graph)),
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text("Plantfi Hardware Support"),
                      backgroundColor: Color(0xFF9AFF26),
                      icon: Icon(Icons.help_center))
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
