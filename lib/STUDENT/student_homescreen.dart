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

  @override
  Widget build(BuildContext context) {
    print('ID ' + widget.userId);
    return Scaffold(
        appBar: AppBar(
          title: Text('Student'),
          actions: [
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
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome Student'),
                Text(
                    'You have not been added yet to a classroom. Please inform your teacher or enter a classroom code and wait for your teacher to accept your request.'),
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
                        await FirebaseFirestore.instance
                            .collection('Student')
                            .doc(documentId)
                            .update({
                          'Student Request':
                              FieldValue.arrayUnion([widget.userId]),
                        });
                        codeController.clear();
                        EasyLoading.showSuccess(
                            'Your request has been successfully sent. Please wait for your teacher to confirm it.');
                        print('Classroom exists. Document ID: $documentId');
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
        ));
  }
}
