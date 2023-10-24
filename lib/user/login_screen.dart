import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:acespeak/user/user_screen.dart';
import 'package:acespeak/user/welcome_page_screen.dart';

import '../STUDENT/student_registration_screen.dart';
import 'forgotpassword.dart';
import 'verifyemail.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var obscurePassword = true;
  final _formkey = GlobalKey<FormState>();
  final collectionPath = 'users';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    if (_formkey.currentState!.validate()) {
      EasyLoading.show(status: 'Processing...');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((userCredential) async {
        String collectionPath = 'users';
        String userId = userCredential.user!.uid;
        final docSnapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(userId)
            .get();
        dynamic data = docSnapshot.data();
        EasyLoading.dismiss();
        passwordController.clear();
        print("USER LOGIN");
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return VerifyEmailPage(userId: userId);
        })));
      }).catchError((err) {
        print(err);
        EasyLoading.showError('Invalid email and/or password.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/Choose.jpg'),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            children: [
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
              Image.asset('assets/images/logo1.png'),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign in now to get started',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Email Address',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required. Please enter an email address.';
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your email address',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '*Required. Please enter your password.';
                                      }
                                      if (value.length <= 6) {
                                        return 'Password should be more than 6 characters.';
                                      }
                                      return null;
                                    },
                                    obscureText: obscurePassword,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscurePassword = !obscurePassword;
                                          });
                                        },
                                        icon: Icon(obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (ctx) {
                                          return ForgotPasswordScreen();
                                        }));
                                      },
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: login,
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 102, 212, 118),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account yet?"),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentRegistration()));
                                          },
                                          child: Text('Sign up here'))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
