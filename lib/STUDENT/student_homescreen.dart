import 'package:acespeak/STUDENT/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../user/welcome_page_screen.dart';

class StudentScreen extends StatefulWidget {
  final String userId;

  const StudentScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final _formkey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  int avatar = 0;
  String grade = '';
    @override
  void initState() {
    super.initState();
    StudentData();
  }

  void StudentData() async {
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
        grade = data['Grade'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print('ID ' + widget.userId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return UpdateStudentProfile(userId: widget.userId);
                  }));
                },
                child: CircleAvatar(
                  child: Image.asset('assets/avatar/a' + avatar.toString() + '.png'),
                ),
              ),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return WelcomPageScreen();
                  }));
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/classroom_request.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.35),
                    Text('Welcome Student', style: TextStyle(fontSize: 28, color: Color.fromARGB(255, 9, 99, 174), fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text('You have not been added yet to a classroom. Please inform your teacher or enter a classroom code and wait for your teacher to accept your request. Thank you', textAlign: TextAlign.justify,),
                    ),
                    TextFormField(
                      key: Key('classroom_code_field'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required. Please enter the Classroom code.';
                        }
                        return null;
                      },
                      controller: codeController,
                      decoration: const InputDecoration(
                        hintText: 'Please enter the Classroom code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                      key: Key('submit_button'),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          final classroomCode = codeController.text;
                          final querySnapshot = await FirebaseFirestore.instance
                              .collection('classroom')
                              .where('Class Code', isEqualTo: classroomCode)
                              .get();
                          if (querySnapshot.docs.isNotEmpty) {
                            final documentId = querySnapshot.docs.first.id;
                            final classGrade = querySnapshot.docs.first['Grade'];
                            if(classGrade == grade){
                            await FirebaseFirestore.instance
                                .collection('classroom')
                                .doc(documentId)
                                .update({
                              'Student Request':
                                  FieldValue.arrayUnion([widget.userId]),
                            });
                            codeController.clear();
                            EasyLoading.showSuccess(
                                'Your request has been successfully sent. Please wait for your teacher to confirm it.');
                            print('Classroom exists. Document ID: $documentId');
                            }else{
                              EasyLoading.showInfo("Your grade is not the same as the classroom code you entered.");
                            }
                          } else {
                            EasyLoading.showError('Classroom code does not exist');
                            print('Classroom code does not exist.');
                          }
                        }
                      },
                      child: Text('Submit'),
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
