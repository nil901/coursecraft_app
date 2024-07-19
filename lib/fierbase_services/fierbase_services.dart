import 'dart:async';


import 'package:coursecraft_app/screens/auth/login_screen.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServics{
  
  void  isLogin(context){
    final _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;
  if(user != null){
 Timer(Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }else{
     Timer(Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

   
  }
}