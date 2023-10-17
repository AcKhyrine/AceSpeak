import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          'Error :( \n Check your internet connection',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
