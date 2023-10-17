
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/Cloud.png')
            )
        ),
        child: const Center(child: CircularProgressIndicator()));
  }
}