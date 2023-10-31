import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../STUDENT/HOME/student_classroom.dart';

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
  } else {
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return ClassRoomScreen(userId: widget.userId);
      }));
    });
    // assessment();
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

  void assessment(documentId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) {
        //       return AvatarScreen(userId: widget.userId,);
        //     },
        //   ),
        // );
        return;
      }
      else{
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['assessment']!= null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return ClassRoomScreen(userId: widget.userId);
            },
          ),
        );return;
      } else {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) {
        //       return AvatarScreen(userId: widget.userId);
        //     },
        //   ),
        // );return;
      }
      }

      
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
Widget build(BuildContext context) => isEmailVerified
    ? CircleAvatar()
    : Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Image.asset('assets/images/frame3.jpg', width: double.infinity,),
              SizedBox(height: 15,),
              Text(
                'A verification email has been sent to your email.', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Navigator.pop(context);
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