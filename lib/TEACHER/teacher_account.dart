import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:acespeak/TEACHER/teacher_homescreen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TeacherAccount extends StatefulWidget {
  final String userID;
  const TeacherAccount({super.key, required this.userID});

  @override
  State<TeacherAccount> createState() => _TeacherAccountState();
}

class _TeacherAccountState extends State<TeacherAccount> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final schoolController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final collectionPath = 'users';

  void validateInput() {
    //cause form to validate
    if (_formkey.currentState!.validate()) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        text: null,
        title: 'Are you sure you want to update?',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        onConfirmBtnTap: () {
          //yes
          EasyLoading.showSuccess('Your account profile has been updated.');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeacherScreen(userId: widget.userID)));
          updateData();
        },
      );
    }
  }

  final databaseReference = FirebaseFirestore.instance;
  Future<void> updateData() async {
    await databaseReference.collection('users').doc(widget.userID).update({
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'school': schoolController.text,
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userID)
        .get();

    if (snapshot.exists) {
      setState(() {
        dynamic data = snapshot.data();
        firstNameController.text = data['firstname'];
        lastNameController.text = data['lastname'];
        schoolController.text = data['school'];
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
                fit: BoxFit.fitWidth)),
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherScreen(
                          userId: widget.userID,
                        ),
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
                              'Update account profile',
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'First Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter your first name.';
                                        }
                                        return null;
                                      },
                                      controller: firstNameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your first name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Last Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter your last name.';
                                        }
                                        return null;
                                      },
                                      controller: lastNameController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your last name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'School Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required. Please enter your school name.';
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
                                    SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: validateInput,
                                        child: Text(
                                          'Update',
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
