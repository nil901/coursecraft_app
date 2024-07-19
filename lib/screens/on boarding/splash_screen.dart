import 'dart:async';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/fierbase_services/fierbase_services.dart';
import 'package:coursecraft_app/screens/on%20boarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServics().isLogin(context);
    //gotoNext();
  }

  gotoNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(
        builder: (context) {
          return const OnboardingScreen();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('${AppImages.onboardingImages}splash.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
