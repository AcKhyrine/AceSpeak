import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddStudent extends StatefulWidget {
  final String userId;
  final String docID;

  AddStudent({Key? key, required this.userId, required this.docID})
      : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List<Map<String, dynamic>> fetchedData = [];

  Future<void> fetchData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          data['documentID'] = documentSnapshot.id;
          setState(() {
            fetchedData.add(data);
            print('Retrieved data: $fetchedData');
          });
        }
      } else {
        setState(() {
          print('No document found.');
        });
      }
    } catch (e) {
      print('Error retrieving document: $e');
    }
  }

  Future<void> searchStudent(String searchQuery) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .where('School', isEqualTo: fetchedData[0]['school'])
          .get();

      List<Map<String, dynamic>> searchData = [];

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic>? data =
              doc.data() as Map<String, dynamic>?;
          if (data != null) {
            data['documentID'] = doc.id;
            String firstName =
                data['Firstname'].toString().toLowerCase();
            String lastName = data['Lastname'].toString().toLowerCase();
            String search = searchQuery.toLowerCase();

            if (firstName.contains(search) || lastName.contains(search)) {
              searchData.add(data);
            }
          }
        });

        setState(() {
          fetchedData = searchData;
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                searchStudent(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fetchedData.length,
              itemBuilder: (context, index) {
                if (fetchedData[index]['Firstname'] == null ||
                    fetchedData[index]['Lastname'] == null) {
                  return SizedBox.shrink();
                } else {
                  return ListTile(
                    title: Text(
                      '${fetchedData[index]['Firstname']} ${fetchedData[index]['Lastname']}',
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Student')
                            .doc(widget.docID)
                            .update({
                          'StudentList': FieldValue.arrayUnion(
                            [fetchedData[index]['documentID']],
                          ),
                        });
                        EasyLoading.showSuccess('Added successfully');
                      },
                      icon: Icon(Icons.add),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
