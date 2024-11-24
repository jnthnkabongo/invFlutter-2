import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bboxxlog/pages/home_page.dart';

class MyLoadingPage extends StatefulWidget {
  const MyLoadingPage({super.key, required this.title });

  final String title;
  @override
  State<MyLoadingPage> createState() => _MyloadingPageState();
}

class _MyloadingPageState extends State<MyLoadingPage> {

  @override
  void initState(){
    super.initState();
    loadAnimation();
  }

Future<Timer> loadAnimation() async{
  return Timer(
    const Duration(seconds: 10),
    onLoaded
    );
}

  void onLoaded(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          //child: Lottie.asset("assets/animations/loading")
          //child: Lottie.asset("assets/animations/loading.json")
          child: Lottie.asset(
            "assets/animations/loading.json",
            repeat: true
            ),
        ),
    );
  }
}







