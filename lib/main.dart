import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'Screens/card_detail.dart';
import 'Screens/card_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/card': (BuildContext context) => CardDetail()
      },
      theme: ThemeData(
        fontFamily: 'Candara'
      ),
      home: SplashScreenView(
        navigateRoute: const CardList(),
        duration: 800,
        imageSize: 150,
        imageSrc: "assets/images/planeswalker.png",
        backgroundColor: Colors.black,
      ),
    );
  }
}

