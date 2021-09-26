import 'package:flutter/material.dart';
import 'package:plantfi_application/screens/plantfiscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/plantfiscreen': (BuildContext context) => PlantScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: PlantScreen(),
    );
  }
}
