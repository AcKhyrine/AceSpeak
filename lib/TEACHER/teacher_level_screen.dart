import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acespeak/TEACHER/teacher_homescreen.dart';
import 'package:acespeak/TEACHER/teacher_lesson_screen.dart';

class TeacherLevelScreen extends StatefulWidget {
  final String userid;
  const TeacherLevelScreen({super.key, required this.userid});

  @override
  State<TeacherLevelScreen> createState() => _TeacherLevelScreenState();
}

class _TeacherLevelScreenState extends State<TeacherLevelScreen> {
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
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherScreen(
                      userId: widget.userid,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Text(
              'Choose level',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherLessonScreen(
                                      uid: widget.userid,
                                    )));
                      },
                      child: Text(
                        'Level 1',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherLessonScreen(
                                      uid: widget.userid,
                                    )));
                      },
                      child: Text(
                        'Level 2',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherLessonScreen(
                                      uid: widget.userid,
                                    )));
                      },
                      child: Text(
                        'Level 3',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherLessonScreen(
                                      uid: widget.userid,
                                    )));
                      },
                      child: Text(
                        'Level 4',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 102, 212, 118),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
