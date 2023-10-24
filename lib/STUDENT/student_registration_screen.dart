import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:acespeak/user/user_screen.dart';
import '../user/verifyemail.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  var obscurePassword = true;
  final _formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var parentController = TextEditingController();
  var schoolController = TextEditingController();
  var gradeController = TextEditingController();
  String? _selectedGrade;
  void registerUser() async {
    try {
      EasyLoading.show(
        status: 'Processing...',
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'null-usercredential');
      }
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'Firstname': firstnameController.text,
        'Lastname': lastnameController.text,
        'Parent Name': parentController.text,
        'School': schoolController.text,
        'Grade': gradeController.text,
        'role': 'Student',
        'avatar' : 0
      });
      EasyLoading.showSuccess('User account has been registered.');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailPage(userId: uid),
        ),
      );
    } on FirebaseAuthException catch (ex) {
      EasyLoading.showError(ex.toString());
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
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context)
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
                              'Sign up now to get started',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Parent\'s Full Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter your full name.';
                                        }
                                        return null;
                                      },
                                      controller: parentController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your full name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Student\'s First Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter student\'s first name.';
                                        }
                                        return null;
                                      },
                                      controller: firstnameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter student\'s first name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Child\'s Last Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter student\'s last name.';
                                        }
                                        return null;
                                      },
                                      controller: lastnameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter student\'s last name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'School\'s Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter school\'s name.';
                                        }
                                        return null;
                                      },
                                      controller: schoolController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your school\'s name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Grade Level',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    DropdownButtonFormField<String>(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please select a grade level.';
                                        }
                                        return null;
                                      },
                                      value: _selectedGrade,
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            gradeController.text = newValue;
                                          });
                                        }
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Grade 1',
                                          child: Text('Grade 1'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Grade 2',
                                          child: Text('Grade 2'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Grade 3',
                                          child: Text('Grade 3'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Grade 4',
                                          child: Text('Grade 4'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Grade 5',
                                          child: Text('Grade 5'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Grade 6',
                                          child: Text('Grade 6'),
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'Select your grade level',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Parent\'s Email Address',
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
                                      height: 20,
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
                                        hintText: 'Enter a password',
                                        border: const OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscurePassword =
                                                  !obscurePassword;
                                            });
                                          },
                                          icon: Icon(obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
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
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromARGB(
                                                    255, 190, 190, 190),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                registerUser();
                                              }
                                            },
                                            child: Text('Sign up'),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color.fromARGB(
                                                    255, 102, 212, 118),
                                              ),
                                            ),
                                          ),
                                        ),
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
      ),
    );
  }
}
