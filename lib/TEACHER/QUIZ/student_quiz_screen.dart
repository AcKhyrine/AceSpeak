import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentQuizScreen extends StatefulWidget {
  final String classCode;
  final String student;
  final String quiz;

  const StudentQuizScreen({
    Key? key,
    required this.classCode,
    required this.student,
    required this.quiz,
  }) : super(key: key);

  @override
  _StudentQuizScreenState createState() => _StudentQuizScreenState();
}

class _StudentQuizScreenState extends State<StudentQuizScreen> {
  List<String> fetchedData = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('quizScore')
          .where(FieldPath.documentId, isEqualTo: widget.student + widget.classCode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          fetchedData = List<String>.from(data['_' + widget.quiz]);
          break;
        }
      } else {
        setState(() {
          print('No documents found.');
        });
      }
    } catch (e) {
      print('Error retrieving documents: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Answers'),
            if (isLoading)
              CircularProgressIndicator() 
            else
              Expanded(
                child: ListView.builder(
                  itemCount: fetchedData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: Key('list_item_$index'), 
                      title: Text((index + 1).toString() + '. ' + fetchedData[index]),
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
