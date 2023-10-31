import 'package:acespeak/user/student_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:acespeak/user/login_screen.dart';
import 'package:acespeak/user/user_screen.dart';
import 'package:acespeak/welcome_message_screen.dart';

class WelcomPageScreen extends StatelessWidget {
  const WelcomPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/signinup.jpg'),
              fit: BoxFit.fitWidth),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                        builder: (context) => WelcomeMessage(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 130, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Don't have an account yet?",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 130, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
