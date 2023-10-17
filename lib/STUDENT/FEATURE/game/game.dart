import 'package:acespeak/STUDENT/FEATURE/game/findobject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'animal.dart';
import 'memorygame/managers/game_manager.dart';
import 'memorygame/pages/game_page.dart';

class GameScreen extends StatefulWidget {
  final String userId;
  final String grade;
  const GameScreen({super.key, required this.userId, required this.grade});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return AnimalGameScreen(
                      userId: widget.userId, grade: widget.grade);
                }));
              },
              child: Text('Find Animal Name'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => GameManager(),
                      child: GamePage(),
                    ),
                  ),
                );
              },
              child: Text('Memory Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                  return FindObjects(
                     userId: widget.userId, grade: widget.grade
                  );
                }));
              },
              child: Text('Find Objects'),
            ),
          ],
        ),
      ),
    );
  }
}
