import 'package:acespeak/0LD_CODE_TEACHER/QUIZ/student_quiz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherQuizzesScore extends StatefulWidget {
  final String teacherID;
  final String classCode;
  final String quiz;
  const TeacherQuizzesScore({super.key, required this.teacherID, required this.classCode, required this.quiz});

  @override
  State<TeacherQuizzesScore> createState() => _TeacherQuizzesScoreState();
}

class _TeacherQuizzesScoreState extends State<TeacherQuizzesScore> {
  List<String> fetchedData = [];
  List<dynamic> fetchedStudents = [];
  List<Map<String, dynamic>> combinedData = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

Future<void> fetchData() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('classroom')
        .where('Teacher', isEqualTo: widget.teacherID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data['Class Code'] == widget.classCode) {
          fetchedData = List<String>.from(data['StudentList']);
          break; 
        }
      }
      await StudentsNames(fetchedData);

    } else {
      setState(() {
        print('No documents found.');
      });
    }
  } catch (e) {
    print('Error retrieving documents: $e');
  }
}

Future<void> StudentsNames(List<String> studentIds) async {
  try {
    List<dynamic> studentNames = [];

    for (String studentId in studentIds) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isEqualTo: studentId) 
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String fullName = data['Firstname'] + ' ' + data['Lastname'];
        studentNames.add(fullName);

        QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
          .collection('quizScore')
          .where(FieldPath.documentId, isEqualTo: studentId+widget.classCode) 
          .get();

      if (querySnapshot1.docs.isNotEmpty) {
        QueryDocumentSnapshot doc = querySnapshot1.docs.first;
        Map<String, dynamic> data1 = doc.data() as Map<String, dynamic>;
        String quiz = data1[widget.quiz].toString();
        combinedData.add({
            'id': studentId,
            'student': fullName,
            'quiz':quiz
          });
      } else {
        combinedData.add({
            'id': studentId,
            'student': fullName,
            'quiz':'not taken'
          });
        print('No student ID found: $studentId');
      }
        
      } else {
        print('No document found for student ID: $studentId');
      }
    }

    setState(() {
      fetchedStudents = studentNames;
    });
  } catch (e) {
    print('Error retrieving documents: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Students'),
              ],
            ),
            Expanded(
            child: Container(
              height: 400, 
              child: ListView.builder(
                itemCount: combinedData.length,
                itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                          return StudentQuizScreen(student: combinedData[index]['id'].toString(), classCode: widget.classCode, quiz:widget.quiz);
                        })));
                      },
                      child: ListTile(
                        title: Text(combinedData[index]['student'].toString()),
                        trailing: Text(combinedData[index]['quiz'].toString()),
                      ),
                    );
                },
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
