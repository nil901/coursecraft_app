import 'package:coursecraft_app/core/app_color.dart';
import 'package:flutter/material.dart';

class Config {
  static const String userURL = '';

//============================= END POINT ====================================//

  static const String signUp = '';
  static const String login = '';
}

//============================= APP LOADER ====================================//

class Loader {
  showLoader(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: Colors.grey.shade100,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child:
                        CircularProgressIndicator(color: AppColor.blackcolor),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}
