import 'package:acespeak/STUDENT/HOME/LESSONS/units.dart';
import 'package:flutter/material.dart';

import '../map_screen.dart';
import '../TILES/tiles_screen.dart';

class NavigateUserChoice extends StatefulWidget {
  final String userid;
  final String grade;
  const NavigateUserChoice({super.key, required this.userid, required this.grade});

  @override
  State<NavigateUserChoice> createState() => _NavigateUserChoiceState();
}

class _NavigateUserChoiceState extends State<NavigateUserChoice> {
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
                'assets/images/_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.all(screenHeight * .06),
                    child: Text("Please select your preferred method for your learning experience:", style: TextStyle(color: Color(0xFF07883A), fontWeight: FontWeight.bold, fontSize: screenHeight * 0.025, ), textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return MapScreen(userId : widget.userid, grade : widget.grade);
                      })));
                    },
                    child: Image.asset('assets/images/map.png')),
                  
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return TilesScreen( userId : widget.userid, grade : widget.grade);
                      }));
                    },
                    child: Image.asset('assets/images/tiles.png')),
                  
                ],
              ),
            ),
             Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return UnitScreen(userid: widget.userid);
                            }));
                        },
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
