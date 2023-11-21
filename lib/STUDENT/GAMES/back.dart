import 'package:acespeak/STUDENT/GAMES/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigateBack extends StatefulWidget {
  final String userId;

  const NavigateBack({Key? key, required this.userId}) : super(key: key);

  @override
  State<NavigateBack> createState() => _NavigateBackState();
}

class _NavigateBackState extends State<NavigateBack> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Center(child: Image.asset('assets/L1.gif')),
            ),
          );
        }

        // Navigate to GameScreen when the snapshot is done loading
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return GameScreen(userId: widget.userId);
          })));
        });

        // Placeholder widget while waiting for the navigator to push
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
