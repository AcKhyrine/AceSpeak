import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StudentRequest extends StatefulWidget {
  final String userId;
  final String docID;

  const StudentRequest({Key? key, required this.userId, required this.docID}) : super(key: key);

  @override
  State<StudentRequest> createState() => _StudentRequestState();
}

class _StudentRequestState extends State<StudentRequest> {
  List<Map<String, dynamic>> fetchedData = [];

  @override
  void initState() {
    print('Request ' + widget.docID);
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
                final studentList = data['Student Request'] as List<dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grade: ${data['Grade']} ' + ' Section: ${data['Section']}'),
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
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Student'),
                                              content: Text('Are you sure you want to add this student in the classroom?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore.instance
                                                        .collection('Student')
                                                        .doc(widget.docID)
                                                        .update({
                                                      'StudentList': FieldValue.arrayUnion([student]),
                                                    });

                                                    await FirebaseFirestore.instance
                                                        .collection('Student')
                                                        .doc(widget.docID)
                                                        .update({
                                                      'Student Request': FieldValue.arrayRemove([student]),
                                                    });

                                                    EasyLoading.showSuccess('Added successfully');
                                                    fetchData();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Confirm'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.check),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Student'),
                                              content: Text('Are you sure you want to decline this student request?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: ()async{
                                                    await FirebaseFirestore.instance
                                                        .collection('Student')
                                                        .doc(widget.docID)
                                                        .update({
                                                      'Student Request': FieldValue.arrayRemove([student]),
                                                    });
                                                    setState(() {
                                                      fetchData();
                                                      EasyLoading.showSuccess('successfully removed');
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ),
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
