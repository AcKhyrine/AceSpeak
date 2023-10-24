import 'package:acespeak/TEACHER/QUIZ/teacher_quiz_quizzes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherQuizSection extends StatefulWidget {
  const TeacherQuizSection({Key? key}) : super(key: key);
  final String teacherID = 'yTXIWhMy3BQ7QGXLu2YlWOiVr8o2';

  @override
  State<TeacherQuizSection> createState() => _TeacherQuizSectionState();
}

class _TeacherQuizSectionState extends State<TeacherQuizSection> {
  List<Map<String, dynamic>> fetchedData = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Class Room'),
              ],
            ),
            Expanded(
            child: Container(
              height: 400, 
              child: ListView.builder(
                itemCount: fetchedData.length,
                itemBuilder: (context, index) {
                  final data = fetchedData[index];
                  if (data['Grade'] == "Grade 6") {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                          return TeacherQuizzesScreen(teacherID: widget.teacherID, classCode: data['Class Code']);
                        }));
                      },
                      child: ListTile(
                        title: Text('Section: ${data['Section']}'),
                      ),
                    );
                  } else {
                    return SizedBox.shrink(); 
                  }
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
