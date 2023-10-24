
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_student.dart';
import 'student_request.dart';

class ClassRoomStudent extends StatefulWidget {
  final String docID;
  final String userId;

  const ClassRoomStudent({Key? key, required this.docID, required this.userId})
      : super(key: key);

  @override
  State<ClassRoomStudent> createState() => _ClassRoomStudentState();
}

class _ClassRoomStudentState extends State<ClassRoomStudent> {
  List<Map<String, dynamic>> fetchedData = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Student')
          .doc(widget.docID)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          fetchedData = [docSnapshot.data() as Map<String, dynamic>];
          print('Retrieved data: $fetchedData');
        });
      } else {
        setState(() {
          print('No document found.');
        });
      }
    } catch (e) {
      print('Error retrieving document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: fetchedData.length,
              itemBuilder: (context, index) {
                final data = fetchedData[index];
                final studentList = data['StudentList'] as List<dynamic>;
                final studentRequest = data['Student Request'].length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grade: ${data['Grade']} '+ ' Section: ${data['Section']}'),
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return StudentRequest(userId: widget.userId, docID: widget.docID);
                                    }));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Request'),
                                      SizedBox(width: 4.0),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                        child: Text(
                                          studentRequest.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return AddStudent(userId: widget.userId, docID: widget.docID);
                              }));
                              });
                            }, icon: Icon(Icons.add_box))
                          ],
                        )
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: studentList.length,
                      itemBuilder: (context, studentIndex) {
                        final student = studentList[studentIndex];
                        print(student);
                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(student)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Text('No student found for ID: $student');
                            }

                            final studentData = snapshot.data!.data() as Map<String, dynamic>;
                            final firstName = studentData['Firstname'] ?? 'N/A';
                            final lastName = studentData['Lastname'] ?? 'N/A';

                            return ListTile(
                              title: Text('$firstName $lastName'),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
