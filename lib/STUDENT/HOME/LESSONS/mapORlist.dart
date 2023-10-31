import 'package:acespeak/STUDENT/HOME/LESSONS/units.dart';
import 'package:flutter/material.dart';

import '../map_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return UnitScreen(userid: widget.userid);
          })));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return MapScreen(userId : widget.userid, grade : widget.grade);
              })));
            }, child: Text('Map')),
            ElevatedButton(onPressed: (){

            }, child: Text('List')),
          ],
        ),
      ),
    );
  }
}