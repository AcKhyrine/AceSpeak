import 'package:acespeak/TEACHER/QUIZ/teacher_quiz_scores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherQuizzesScreen extends StatefulWidget {
  final String teacherID;
  final String classCode;
  const TeacherQuizzesScreen({super.key, required this.teacherID, required this.classCode});

  @override
  State<TeacherQuizzesScreen> createState() => _TeacherQuizzesScreenState();
}

class _TeacherQuizzesScreenState extends State<TeacherQuizzesScreen> {
  List<Map<String, dynamic>> fetchedData = [];
  List<dynamic> fetchedQuiz = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

Future<void> fetchData() async {
  try {
    List<String> quiz = []; 

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
         .collection('classQuiz')
          .where(FieldPath.documentId, isEqualTo: widget.teacherID+widget.classCode)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          quiz = List<String>.from(data['quiz']);
          break; 
      }
      await fetchQuiz(quiz);

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

Future<void> fetchQuiz(List<String> quiz) async {
  try {
    List<dynamic> quizzes = [];

    for (String quizID in quiz) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('quiz')
          .where(FieldPath.documentId, isEqualTo: quizID) 
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String fullName = data['title'];
        quizzes.add(fullName);
      } else {
        print('No document found for student ID: $quizID');
      }
    }

    setState(() {
      fetchedQuiz = quizzes;
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
                Text('List of Quizzes'),
              ],
            ),
            Expanded(
            child: Container(
              height: 400, 
              child: ListView.builder(
                itemCount: fetchedQuiz.length,
                itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                          return TeacherQuizzesScore(classCode: widget.classCode, teacherID: widget.teacherID, quiz: fetchedQuiz[index].toString());
                        })));
                      },
                      child: ListTile(
                        title: Text(fetchedQuiz[index].toString()),
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
