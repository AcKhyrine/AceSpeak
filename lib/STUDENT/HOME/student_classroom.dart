import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../user/welcome_page_screen.dart';
import '../../user/login_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../AVATAR/update_avatar.dart';
import '../GAMES/game.dart';
import '../LEADERBOARD/leaderboard.dart';
import '../PROFILE/update_profile.dart';
import '../PROGRESS/progress_units.dart';
import 'LESSONS/units.dart'; 

class ClassRoomScreen extends StatefulWidget {
  final String userId;
  const ClassRoomScreen({super.key, required this.userId});

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  int avatar = 0;
  String fname='';
  String lname='';
  String audio = '';
  
  @override
  void initState() {
    super.initState();
    assessment();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  void assessment() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        avatar = data['avatar'];
        fname = data['Firstname'];
        lname = data['Lastname'];
        audio = data['audio'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
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
              children: [
                Container(
                  height: screenHeight * 0.19,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF5F9232),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeight * 0.01,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hi, ' + fname + ' ' + lname,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.008),
                                  Text(
                                    'Let’s start learning',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.015,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: (){
                                  _showDialog(context);
                                },
                                child: AvatarGlow(
                                  glowColor: Colors.white,
                                  endRadius: 50,
                                  duration: Duration(seconds: 10),
                                  repeat: true,
                                  showTwoGlows: true,
                                  repeatPauseDuration: Duration(seconds: 5),
                                  child: Image.asset(
                                    avatar != 0 ? 'assets/avatar/a' + avatar.toString() + '.png'
                                    : 'assets/avatar/a1.png',
                                    width: screenWidth * 0.20,
                                    height: screenWidth * 0.20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1.5, 
                          color: const Color.fromARGB(255, 255, 255, 255), 
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return UnitScreen(userid:widget.userId);
                            }));
                          },
                          child: Image.asset('assets/images/image 3.png')),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        //     //   return Quizzes(
                        //     //       userId: widget.userId, grade: widget.grade, classroomID: widget.classroomID,);
                        //     // }));
                        //   },
                        //   child: Image.asset('assets/images/image 4.png')),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return GameScreen(
                                  userId: widget.userId);
                            }));
                          },
                          child: Image.asset('assets/images/image 5.png')),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return UpdateAvatar(userId: widget.userId);
                    }));
                  },
                  child: Text('Change Avatar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return ProgressUnitScreen(userid: widget.userId);
                    }));
                  },
                  child: Text('Progress history'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return LeaderBoardScreen();
                    }));
                  },
                  child: Text('leader board'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return UpdateStudentProfile(userId: widget.userId,);
                    }));
                  },
                  child: Text('Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (audio == "true") {
                      audio = "false";
                      EasyLoading.showSuccess('Volume turn off Sucessfully');
                    } else {
                      audio = "true";
                      EasyLoading.showSuccess('Volume turn on Sucessfully');
                    }
                    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
                      'audio': audio
                    }).then((_) {
                      print('updated successfully');
                    }).catchError((error) {
                      print('Error updating $error');
                    });
                    setState(() {
                    });
                  },
                  child: audio == "true"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Audio ON'),
                            Icon(Icons.volume_up)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Audio OFF'),
                            Icon(Icons.volume_off)
                          ],
                        ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return WelcomPageScreen();
                    }));
                  },
                  child: Text('logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
