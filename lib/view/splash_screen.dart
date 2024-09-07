import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_to_do_app/main.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      isUserLogin();
    });
  }

  Future isUserLogin() async {
    Box loginData = Hive.box('login');
    String loginUserEmail = loginData.get('userEmail') ?? '';
    String loginUserPass = loginData.get('userPass') ?? '';

    Timer(const Duration(milliseconds: 1800), () async {
      if (loginUserEmail != '' && loginUserPass != '') {
        Get.to(HomeScreen());
      } else {
        Get.to(LogInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: screenSize.width * .2,
              top: screenSize.height * .2,
              width: screenSize.width * .6,
              height: screenSize.height * .6,
              child: Image.asset(
                'assets/images/logo.png',
              ),)
        ],
      ),
    );
  }
}
