import 'package:acespeak/0LD_CODE_TEACHER/quiz.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QuizScreenAdd extends StatefulWidget {
  final String quizID;

  const QuizScreenAdd({Key? key, required this.quizID}) : super(key: key);

  @override
  _QuizScreenAddState createState() => _QuizScreenAddState();
}

class _QuizScreenAddState extends State<QuizScreenAdd> {
  var question = TextEditingController();
  var answer = TextEditingController();
  var choice = TextEditingController();
  List<String> listchoices = [];
  final firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> quizData = [];
  List<dynamic> listQuizID = [];

  @override
  void initState() {
    print(widget.quizID);
    displayQuiz();
    super.initState();
  }

  Future<void> displayQuiz() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .doc(widget.quizID)
        .get();

    if (!snapshot.exists) {
      print('No documents found for class quiz');
      return;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data!['questions'] != null) {
      listQuizID = data['questions'];
    }

    quizData.clear(); 

    for (int i = 0; i < listQuizID.length; i++) {
      final quizDoc = await firestore.collection('quizzes').doc(listQuizID[i]).get();
      if (!quizDoc.exists) {
        print('No quiz document found with ID: ${listQuizID[i]}');
        return;
      }
      final quizDataMap = quizDoc.data() as Map<String, dynamic>;
      setState(() {
        quizData.add(quizDataMap);
      });
    }

  } catch (e) {
    print('Error fetching data: $e');
  }
}


  Future<void> createQuiz() async {
    try {
      if (choice.text != '') {
        listchoices.add(choice.text);
        choice.clear();
      }

      final quizDocRef = await firestore.collection('quizzes').add({
        'question': question.text,
        'answer': answer.text,
        'choices': listchoices,
      });

      final teacherQuizUpdate = firestore.collection('quiz').doc(widget.quizID);
      await teacherQuizUpdate.update({
        'quiz': FieldValue.arrayUnion([quizDocRef.id]),
      });
      displayQuiz();
      question.clear();
      answer.clear();
      listchoices.clear();
      print("added question");
    } catch (e) {
      print('Error creating quiz: $e');
      EasyLoading.showError('Quiz submission failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return QuizScreen();
            })));
          },
          icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Text('Question'),
          TextField(
            controller: question,
          ),
          Text('Answer'),
          TextField(
            controller: answer,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Choices'),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (choice.text.isNotEmpty) {
                      listchoices.add(choice.text);
                      choice.clear();
                    }
                  });
                },
                icon: Icon(Icons.add_box_rounded),
              ),
            ],
          ),
          TextField(
            controller: choice,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listchoices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listchoices[index]),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        listchoices.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.remove_circle),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createQuiz();
            },
            child: Text('Add More Question'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quizData.length,
              itemBuilder: (context, index) {
                final currentQuestion = quizData[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('QUESTION ${index + 1}'),
                        Text('Question: ${currentQuestion['question']}'),
                        Text('Answer: ${currentQuestion['answer']}'),
                        Text('Choices:'),
                        for (var choice in currentQuestion['choices']) Text(choice),
                        SizedBox(height: 20,)
                      ],
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
