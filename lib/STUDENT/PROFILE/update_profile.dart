import 'package:acespeak/STUDENT/HOME/student_classroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateStudentProfile extends StatefulWidget {
  final String userId;
  const UpdateStudentProfile({super.key, required this.userId});

  @override
  State<UpdateStudentProfile> createState() => _UpdateStudentProfileState();
}

class _UpdateStudentProfileState extends State<UpdateStudentProfile> {
  final _formkey = GlobalKey<FormState>();
  var lastnameController = TextEditingController();
  var firstnameController = TextEditingController();
  var firstname;
  var lastname;
  
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
      firstname = data['Firstname'];
      lastname = data['Lastname'];
      firstnameController.text = firstname; 
      lastnameController.text = lastname;   
    });
  } catch (e) {
    print('Error fetching data: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
             Positioned.fill(
              child: Image.asset(
                'assets/images/image 2.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                SizedBox(height: screenHeight * .065,),
                Center(child: Text('Student Profile', style: TextStyle(fontSize: screenHeight * .045, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 3, 48, 85)),)),
                  SizedBox(height: 25,),
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Firstname',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required. Please enter first name.';
                            }
                            return null;
                          },
                          controller: firstnameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your firstname name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Lastname',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required. Please enter last name.';
                            }
                            return null;
                          },
                          controller: lastnameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your lastname name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    // Call a function to update the school and grade values
                                    updateProfile();
                                  }
                                },
                                child: Text('Update'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
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
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                    return ClassRoomScreen(userId: widget.userId);
                                  })));
                                },
                                child: Text('Back'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 180, 133, 133),
                                  ),
                                ),
                              ),
                              
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() {
    final updatedfirstname = firstnameController.text;
    final updatedlastname = lastnameController.text;
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'Firstname': updatedfirstname,
      'Lastname': updatedlastname,
    }).then((_) {
      EasyLoading.showSuccess('Updated Sucessfully');
      print('Profile updated successfully');
    }).catchError((error) {
      print('Error updating profile: $error');
    });
  }
}
