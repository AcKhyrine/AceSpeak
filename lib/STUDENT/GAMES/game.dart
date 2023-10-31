
import 'package:acespeak/STUDENT/GAMES/spelling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'animal.dart';
import 'findobject.dart';

class GameScreen extends StatefulWidget {
  final String userId;
  const GameScreen({super.key, required this.userId});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
    super.initState();
  }
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
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 3, 48, 85),)),
                    Text('Back'),
                  ],
                ),
                SizedBox(height: screenHeight * .079,),
                Center(child: Image.asset('assets/images/games.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return FindObjects(
                                userid: widget.userId,);
                          }));
                        },
                        child: Image.asset('assets/images/fndobject.png', width: screenWidth * 30,)),
                        SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return AnimalGameScreen(
                                userId: widget.userId);
                          }));
                        },
                        child: Image.asset('assets/images/listenmatch.png', width: screenWidth * 25)),
                      SizedBox(height: screenHeight * .01,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return SpellingGame(
                                userid: widget.userId,);
                          }));
                        },
                        child: Image.asset('assets/images/spellings.png')),
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
