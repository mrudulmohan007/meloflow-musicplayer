import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/views/home.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(
        seconds: 1,
      ),
      () => Navigator.pushReplacement(
        context,
        PageTransition(child: Home(), type: PageTransitionType.fade),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'Melo',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: ConstantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'Flow',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
