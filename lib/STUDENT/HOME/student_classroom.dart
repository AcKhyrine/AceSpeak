import 'package:acespeak/STUDENT/DASHBOARD/dashboardScreen.dart';
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
import '../LEARNING/update_learning.dart';
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
                    padding: EdgeInsets.only(left: screenWidth * .08, right: screenWidth * .08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.03,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return UnitScreen(userid:widget.userId);
                            }));
                          },
                          child: Image.asset('assets/images/image 3.png')),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return GameScreen(
                                  userId: widget.userId);
                            }));
                          },
                          child: Image.asset('assets/images/image 5.png')),
                          GestureDetector(
                          onTap: () {
                            _showDialog2(context);
                          },
                          child: Image.asset('assets/images/image 4.png')),
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
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: double.infinity,
            // width: screenWidth * 0.05,
            height: screenHeight * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/board 1.png'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05, left:screenWidth * 0.09, right: screenWidth * 0.09),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close)),
                  ],
                ),
                Container(
                  height: screenHeight * .12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return DashboardScreen(userId: widget.userId);
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                    ),
                    child: Text('Dashboard', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02,),
                Container(
                  height: screenHeight * .12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ProgressUnitScreen(userid: widget.userId);
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                    ),
                    child: Text('Progress history', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02,),
                Container(
                  height: screenHeight * .12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return LeaderBoardScreen();
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                    ),
                    child: Text('leader board', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02,),
                Container(
                  height: screenHeight * .12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return UpdateStudentProfile(userId: widget.userId,);
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                    ),
                    child: Text('Profile', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02,),
                Container(
                  height: screenHeight * .12,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return WelcomPageScreen();
                      }));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFCC4242)), 
                    ),
                    child: Text('logout', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
            ),
          ),
        );
      },
    );
  }

  void _showDialog2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: double.infinity,
            // width: screenWidth * 0.05,
            height: screenHeight * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/board 1.png'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.08, left:screenWidth * 0.09, right: screenWidth * 0.09),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Settings', style: TextStyle(fontSize: screenHeight * 0.1, color: Colors.grey),),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close))
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02,),
                    Container(
                      height: screenHeight * 0.13,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return UpdateAvatar(userId: widget.userId);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                        ),
                        child: Text('Change Avatar', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02,),
                    Container(
                      height: screenHeight * 0.13,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return UpdateLearning(userID: widget.userId);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF07883A)), 
                        ),
                        child: Text('Change Method of Learning', style: TextStyle(color: Colors.white, fontSize: 13),),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05,),
                    Text('Audio Settings', style: TextStyle(color: Colors.grey),),
                    SizedBox(height: screenHeight * 0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            setState(() {
                              audio = "true";
                              EasyLoading.showSuccess('Volume turn on Sucessfully');
                            });
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
                          child: Image.asset(audio == "true" ? 'assets/images/sound.png' : 'assets/images/sound 1.png')),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              Navigator.pop(context);
                              audio = "false";
                              EasyLoading.showSuccess('Volume turn off Sucessfully');
                            });
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
                          child: Image.asset(audio == "true" ? 'assets/images/mute 1.png' : 'assets/images/mute.png'))
                      ],
                    ),
                  ],
                ),
            ),
          ),
        );
      },
    );
  }
}
