import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../STUDENT/MAIN FEATURE/avatar.dart';
import '../STUDENT/assessment test/start.dart';
import '../STUDENT/MAIN FEATURE/student_classroom.dart';
import '../STUDENT/student_homescreen.dart';
import '../TEACHER/teacher_homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyEmailPage extends StatefulWidget {
  final String userId;
  const VerifyEmailPage({super.key, required this.userId});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  final teacherUrl = 'https://casptone-14c19.web.app/#/';
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        if (mounted) {
          checkEmailVerified();
        } else {
          timer.cancel();
        }
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void assessment(grade, documentId, classCode) async {
    print(grade);
    print(classCode);
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+ classCode)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return AvatarScreen(userId: widget.userId, grade: grade,classroomID : documentId);
              // AssessmentStart(userId: widget.userId, grade: grade);
            },
          ),
        );
        return;
      }
      else{
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['assessment']!= null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return ClassRoomScreen(userId: widget.userId, grade: grade, classroomID : documentId);
            },
          ),
        );return;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return AvatarScreen(userId: widget.userId, grade: grade, classroomID : documentId);
              // AssessmentStart(userId: widget.userId, grade: grade);
            },
          ),
        );return;
      }
      }

      
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _launchURL() async {
  if (await canLaunch(teacherUrl)) {
      await launch(teacherUrl, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $teacherUrl';
    }
  }
  @override
Widget build(BuildContext context) => isEmailVerified
    ? FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              final dynamic data = snapshot.data!.data();
              timer?.cancel();
              if (data != null && data['role'] == 'Student') {
                return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future:
                      FirebaseFirestore.instance.collection('classroom').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final studentDocs = snapshot.data!.docs;
                      print('has data');
                      bool foundStudent = false;
                      for (var studentDoc in studentDocs) {
                        final studentData = studentDoc.data();
                        String documentId = studentDoc.id;
                        if (studentData != null &&
                            studentData.containsKey('StudentList')) {
                          final studentList =
                              studentData['StudentList'] as List<dynamic>;
                          String grade = studentData['Grade'] ?? ''; 
                          String classCode = studentData['Class Code'] ?? '';
                          if (studentList.contains(widget.userId)) {
                            print('assessment');
                            print('CLASSROOM: ' + documentId);
                            if (documentId != null) {
                              assessment(grade, documentId, classCode);
                            } else {
                              assessment(grade, documentId = '', classCode);
                            }

                            foundStudent = true;
                            break;
                          }
                        }
                      }

                      if (!foundStudent) {
                        return StudentScreen(userId: widget.userId);
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else {
                return TeacherScreen(userId: widget.userId);
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    : Scaffold(
        appBar: AppBar(
          title: Text('Verify Email'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A verification email has been sent to your email.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  sendVerificationEmail();
                },
                icon: Icon(
                  Icons.email,
                  size: 32,
                ),
                label: Text(
                  'Resend Email',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      );
}