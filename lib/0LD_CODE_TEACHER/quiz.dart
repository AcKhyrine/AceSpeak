import 'package:acespeak/0LD_CODE_TEACHER/quiz2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizScreen extends StatefulWidget {
  final String teacherID = "yTXIWhMy3BQ7QGXLu2YlWOiVr8o2";
  final String classCode = "hNES";

  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController deadline = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> quizData = [];

  @override
  void initState() {
    displayQuiz();
    super.initState();
  }

  Future<void> displayQuiz() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('classQuiz')
          .doc('${widget.teacherID}${widget.classCode}')
          .get();

      if (!snapshot.exists) {
        print('No documents found for class quiz');
        return;
      }

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      List<String> quizDocIDs = List<String>.from(data?["quiz"] ?? []);

      for (var id in quizDocIDs) {
        DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
            .collection('quiz')
            .doc(id)
            .get();
        final quizDataMap = quizSnapshot.data() as Map<String, dynamic>?;

        if (quizDataMap != null) {
          quizDataMap['docID'] = quizSnapshot.id; // Add 'docID' to quiz data
          setState(() {
            quizData.add(quizDataMap);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> createQuiz() async {
    try {
      EasyLoading.show(status: 'Creating Quiz...');

      final quizDocRef = await firestore.collection('quiz').add({
        'deadline': deadline.text,
        'title': title.text,
        'quiz': [],
        'status': "not uploaded"
      });

      final teacherQuizUpdate =
          firestore.collection('classQuiz').doc('${widget.teacherID}${widget.classCode}');
      await teacherQuizUpdate.update({
        'quiz': FieldValue.arrayUnion([quizDocRef.id]),
      });

      EasyLoading.showSuccess('Quiz created successfully!');
      EasyLoading.dismiss();
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return QuizScreenAdd(quizID: quizDocRef.id);
      }));
    } catch (e) {
      print('Error creating quiz: $e');
      EasyLoading.showError('Quiz creation failed');
    }
  }

  Future<void> quizStatus(String data, String status) async {
    status = (status != 'uploaded') ? 'uploaded' : 'not uploaded';

    await firestore.collection('quiz').doc(data).update({
      'status': status,
    });

    setState(() {
      // Only update the status in the local data without re-fetching the entire list.
      final quizIndex = quizData.indexWhere((quiz) => quiz['docID'] == data);
      if (quizIndex != -1) {
        quizData[quizIndex]['status'] = status;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: '),
            TextField(
              controller: title,
            ),
            Text('Deadline: '),
            TextField(
              controller: deadline,
            ),
            ElevatedButton(
              onPressed: createQuiz,
              child: Text('Create'),
            ),
            SizedBox(height: 30),
            Text('List of quizzes'),
            Expanded(
              child: ListView.builder(
                itemCount: quizData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(quizData[index]['title']),
                    subtitle: Text('Quiz ${index + 1}'),
                    trailing: ElevatedButton(
                      child: Text(quizData[index]['status'] == 'uploaded' ? 'Uploaded' : 'Upload'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return quizData[index]['status'] == 'uploaded'
                                ? Colors.pink
                                : Colors.green;
                          },
                        ),
                      ),
                      onPressed: () {
                        quizStatus(quizData[index]['docID'], quizData[index]['status']);
                      },
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
