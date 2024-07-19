// ignore_for_file: must_be_immutable, use_super_parameters

import 'dart:io';
import 'package:coursecraft_app/conts/prefskeys.dart';
import 'package:coursecraft_app/screens/on%20boarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Adjust this path as needed

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    await Hive.openBox('coursecraft').then(
      (value) => runApp(
        MyApp(prefs: value),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  Box prefs;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    PrefObj.preferences = widget.prefs;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          ScreenUtil.init(context, designSize: size);
        }
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Coursecraft',
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
