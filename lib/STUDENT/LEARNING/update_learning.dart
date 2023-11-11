import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../HOME/student_classroom.dart';

class UpdateLearning extends StatefulWidget {
  final String userID;
  const UpdateLearning({super.key, required this.userID});

  @override
  State<UpdateLearning> createState() => _UpdateLearningState();
}

class _UpdateLearningState extends State<UpdateLearning> {
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
                      FirebaseFirestore.instance.collection('users').doc(widget.userID).update({
                        'method': "map"
                      }).then((_) {
                        EasyLoading.showSuccess('Updated Sucessfully');
                        print('Profile updated successfully');
                      }).catchError((error) {
                        print('Error updating profile: $error');
                      });
                    },
                    child: Image.asset('assets/images/map.png')),
                  
                  GestureDetector(
                    onTap: (){
                      FirebaseFirestore.instance.collection('users').doc(widget.userID).update({
                        'method': "tiles"
                      }).then((_) {
                        EasyLoading.showSuccess('Updated Sucessfully');
                        print('Profile updated successfully');
                      }).catchError((error) {
                        print('Error updating profile: $error');
                      });
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
                            return ClassRoomScreen(userId: widget.userID);
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
