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
  var schoolController = TextEditingController();
  var gradeController = TextEditingController();
  var name = TextEditingController();
  var parent = TextEditingController();
  String? _selectedGrade;
  var firstname;
  var lastname;
  var grade;
  var parentName;
  var school;
  
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
        grade = data['Grade'];
        lastname = data['Lastname'];
        parentName = data['Parent Name'];
        school = data['School'];
        
        schoolController.text = school ?? ''; 
        _selectedGrade = grade ?? '';
        name.text = firstname+' '+lastname ?? '';
        parent.text = parentName ?? '';
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
                  
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Name',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.09,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, 
                              width: .5,         
                            ),
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name.text,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Parent/Guardian Name',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.09,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, 
                              width: .5,         
                            ),
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                parent.text,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
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
                                _selectedGrade = newValue;
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
                                  Navigator.pop(context);
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
    final updatedSchool = schoolController.text;
    final updatedGrade = _selectedGrade;
    FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'School': updatedSchool,
      'Grade': updatedGrade,
    }).then((_) {
      EasyLoading.showSuccess('Updated Sucessfully');
      print('Profile updated successfully');
    }).catchError((error) {
      print('Error updating profile: $error');
    });
  }
}
