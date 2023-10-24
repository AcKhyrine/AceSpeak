import 'package:acespeak/STUDENT/FEATURE/game/findobject.dart';
import 'package:acespeak/STUDENT/FEATURE/game/spelling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'animal.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/image 2.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 3, 48, 85),)),
                SizedBox(height: screenHeight * .075,),
                Center(child: Text('GAMES', style: TextStyle(fontSize: screenHeight * .065, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 3, 48, 85)),)),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * .03,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return FindObjects(
                                userid: widget.userId,);
                          }));
                        },
                        child: Image.asset('assets/images/FINDOBJECTS.png', width: screenWidth * 1,)),
                        SizedBox(height: screenHeight * .03,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return AnimalGameScreen(
                                userId: widget.userId, grade: widget.grade);
                          }));
                        },
                        child: Image.asset('assets/images/ANIMALSOUNDS.png', width: screenWidth * 2)),
                      SizedBox(height: screenHeight * .01,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return SpellingGame(
                                userid: widget.userId,);
                          }));
                        },
                        child: Image.asset('assets/images/SPELLING.png')),
                    
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
