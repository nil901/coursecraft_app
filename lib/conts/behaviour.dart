import 'package:flutter/material.dart';

//============================= MU BEHAVIOR ====================================//

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
