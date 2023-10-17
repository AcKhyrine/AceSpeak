import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acespeak/TEACHER/teacher_account.dart';
import 'package:acespeak/TEACHER/teacher_level_screen.dart';
import 'package:acespeak/TEACHER/teacher_score_screen.dart';
import 'package:acespeak/user/login_screen.dart';
import 'package:acespeak/user/welcome_page_screen.dart';

import 'CLASSROOM/classroom_screen.dart';

class TeacherScreen extends StatefulWidget {
  final String userId;
  const TeacherScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login.jpg'),
                fit: BoxFit.fitWidth)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
              ),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final document = snapshot.data!.data();
                    if (document != null &&
                        document.containsKey('firstname') &&
                        document.containsKey('lastname')) {
                      final firstname = document['firstname'];
                      final lastname = document['lastname'];
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Welcome Teacher $firstname!',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return ClassRoomScreen(
                                        userId: widget.userId);
                                  }));
                                },
                                child: Text('Class Room'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 102, 212, 118),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return TeacherLevelScreen(
                                      userid: widget.userId,
                                    );
                                  }));
                                },
                                child: Text('Student Score'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 102, 212, 118),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TeacherAccount(
                                              userID: widget.userId,
                                            )));
                              },
                              child: Text('Teacher Account'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 102, 212, 118),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text('Sign Out'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 102, 212, 118),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return Text('Document not found or missing required fields.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
