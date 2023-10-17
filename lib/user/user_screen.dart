import 'package:flutter/material.dart';
import 'package:acespeak/user/welcome_page_screen.dart';
import '../STUDENT/student_registration_screen.dart';
import '../TEACHER/teacher_registration_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: SafeArea(
          child: Column(
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
                      builder: (context) => WelcomPageScreen(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose your role',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black12,
                      thickness: 5,
                      indent: 15,
                      endIndent: 15,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StudentRegistration();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen,
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'STUDENT',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TeacherRegistration();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen,
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'TEACHER',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
