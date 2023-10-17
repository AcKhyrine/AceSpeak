import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:random_string/random_string.dart';
import 'create_classroom.dart';
import 'student.dart';

class ClassRoomScreen extends StatefulWidget {
  final String userId;
  const ClassRoomScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  final _formkey = GlobalKey<FormState>();
  String randomCode = randomAlphaNumeric(4);
  List<Map<String, dynamic>> fetchedData = [];

  void GenerateCode() {
    setState(() {
      randomCode = randomAlphaNumeric(4);
    });
  }

  @override
  void initState() {
    GenerateCode();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('classroom')
          .where('Teacher', isEqualTo: widget.userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          fetchedData = querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['documentId'] = doc.id;
            return data;
          }).toList();
          print('Retrieved data: $fetchedData');
        });
      } else {
        setState(() {
          print('No documents found.');
        });
      }
    } catch (e) {
      print('Error retrieving documents: $e');
    }
  }

 void updateClassroom(String documentId, Map<String, dynamic> updatedData) async {
  await FirebaseFirestore.instance
      .collection('classroom')
      .doc(documentId)
      .update(updatedData);

  await FirebaseFirestore.instance.collection('Student').doc(documentId).update({
    'Grade': updatedData['Grade'],
    'Section': updatedData['Section'],
  });

  setState(() {
    EasyLoading.showSuccess('updated successfully');
    Navigator.pop(context);
    fetchData();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Class Room'),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return CreateClassRoomScreen(
                            userId: widget.userId,
                            code: randomCode,
                          );
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.add_box),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fetchedData.length,
                itemBuilder: (context, index) {
                  final data = fetchedData[index];
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return ClassRoomStudent(docID : data['documentId'], userId: widget.userId,);
                      })));
                      });
                    },
                    child: ListTile(
                      title:
                          Text('Grade: ${data['Grade']} \nSection: ${data['Section']}'),
                      subtitle: Text('Code: ${data['Class Code']}'),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: Column(
                                      children: [
                                        Form(
                                          key: _formkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Edit CLASSROOM'),
                                              SizedBox(height: 15),
                                              Text('Class Room Code: ' +
                                                  data['Class Code']),
                                              Text('Grade Level'),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Required. Please enter grade level.';
                                                  }
                                                  return null;
                                                },
                                                initialValue: data['Grade'],
                                                onChanged: (value) {
                                                  data['Grade'] = value;
                                                },
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      'Please enter grade level',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text('Section'),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Required. Please enter Section.';
                                                  }
                                                  return null;
                                                },
                                                initialValue: data['Section'],
                                                onChanged: (value) {
                                                  data['Section'] = value;
                                                },
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      'Please enter Section',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text('Start of School Year'),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Required. Please enter start of school year.';
                                                  }
                                                  return null;
                                                },
                                                initialValue:
                                                    data['SY Start'],
                                                onChanged: (value) {
                                                  data['SY Start'] = value;
                                                },
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      'Please enter start of school year',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text('End of School Year'),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Required. Please enter end of school year.';
                                                  }
                                                  return null;
                                                },
                                                initialValue: data['SY End'],
                                                onChanged: (value) {
                                                  data['SY End'] = value;
                                                },
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      'Please enter end of school year',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              updateClassroom(
                                                  data['documentId'], data);
                                            }
                                          });
                                        },
                                        child: Text('Save'),
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
                            icon: Icon(Icons.edit,),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: Text('Are you sure you want to delete?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                         setState(() {
                                           FirebaseFirestore.instance.collection('classroom').doc(data['documentId']).delete();
                                          FirebaseFirestore.instance.collection('Student').doc(data['documentId']).delete();
                                          EasyLoading.showSuccess('deleted successfully');
                                         });
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
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
