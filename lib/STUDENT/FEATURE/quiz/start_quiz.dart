import 'package:acespeak/STUDENT/FEATURE/quiz/quiz_score_screen.dart';
import 'package:acespeak/STUDENT/FEATURE/quiz/show_answer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StartQuizScreen extends StatefulWidget {
  final String quizData;
  final String userId;
  final String classCode;
  final String grade;
  final String classroomID;
  final String title;
  StartQuizScreen({Key? key,required this.title, required this.grade, required this.classroomID, required this.quizData, required this.userId, required this.classCode}) : super(key: key);

  @override
  _StartQuizScreenState createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  List<dynamic> quizItem = [];
  List<Map<String, dynamic>> quizDataList = [];
  int num = 0;
  bool isLoading = true;
  String currentQuestionAudio = "";
  String userAnswer = "";
  final FlutterTts flutterTts = FlutterTts();
  bool play = false;
  String select = '';
  int score = 0;
  @override
  void initState() {
    super.initState();
    quiz();
  }

  void audio(String word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void quiz() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('quiz')
          .doc(widget.quizData)
          .get();

      if (!snapshot.exists) {
        print('No documents found for students in classroom');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['quiz'] != null) {
        quizItem = data['quiz'];
        quizzes();
      } else {
        print('No Class Code');
      }
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void quizzes() async {
    if (quizItem.isNotEmpty) {
      for (var item in quizItem) {
        try {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection('quizzes')
              .doc(item)
              .get();

          if (!snapshot.exists) {
            print('Document does not exist for students in quizzes');
            continue;
          }

          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          if (data['choices'] != null) {
            Map<String, dynamic> quizMap = {
              'question': data['question'],
              'choices': data['choices'],
              'answer': data['answer'],
            };
            quizDataList.add(quizMap);
          } else {
            print('No quiz data found in the document');
          }
          setState(() {});
        } catch (e) {
          print('Error fetching data: $e');
        }
      }
    } else {
      print('No quiz');
    }

    setState(() {
      isLoading = false;
    });
  }

  void goToNextQuestion() {
  if (num < quizDataList.length - 1) {
    setState(() {
      select = '';
      currentQuestionAudio = "";
      num += 1;
      play = false;
    });
  } else {
    print('No more questions');
  }
}


  Future<void> saveScore(answer) async {
  if(answer == "True"){
    try {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('quizScore')
        .doc(widget.userId + widget.classCode);

    DocumentSnapshot docSnapshot = await docRef.get();
    
    if (docSnapshot.exists) {
      await docRef.update({
        widget.title: FieldValue.increment(1),
        '_' + widget.title: FieldValue.arrayUnion([userAnswer]),
        });
      print('Score updated successfully.');
    } else {
      await docRef.set({
        widget.title: 1,
        '_' + widget.title: [userAnswer],
        });
      print('Document created with an initial score of 1.');
    }
  } catch (e) {
    print('Error updating score: $e');
  }
  }else{
    try {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('quizScore')
        .doc(widget.userId + widget.classCode);

    DocumentSnapshot docSnapshot = await docRef.get();
    
    if (docSnapshot.exists) {
      await docRef.update({
        '_' + widget.title: FieldValue.arrayUnion([userAnswer]),
        });
      print('Score updated successfully.');
    } else {
      await docRef.set({
        '_' + widget.title: [userAnswer],
        });
      print('Document created with an initial score of 1.');
    }
  } catch (e) {
    print('Error updating score: $e');
  }
  }
}

/////////////////////////////////////////////////////
// void Answer(userAnswer) async {
//   try {
//     DocumentReference docRef = FirebaseFirestore.instance
//         .collection('quizScore')
//         .doc(widget.userId + widget.classCode);

//     DocumentSnapshot snapshot = await docRef.get();

//     if (snapshot.exists) {
//       await docRef.update({
//         '_' + widget.title: FieldValue.arrayUnion([userAnswer]),
//       });
//       print('Document updated successfully.');
//     } else {
//       await docRef.set({
//         '_' + widget.title: [userAnswer],
//       });
//       print('New document created for user ID: ${widget.userId}');
//     }
//   } catch (e) {
//     print('Error updating/creating document: $e');
//   }
// }

////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> quizData =
        quizDataList.isNotEmpty ? quizDataList[num] : {};
    String question =
        quizData.containsKey('question') ? quizData['question'] : '';
    String answer =
        quizData.containsKey('answer') ? quizData['answer'] : '';
    List<dynamic> choices =
        quizData.containsKey('choices') ? quizData['choices'] : [];
    int no = num + 1;

    if (quizDataList.isNotEmpty && isLoading != true && play == false) {
      currentQuestionAudio = question + "." + choices.join(". ");
      audio(currentQuestionAudio);
    }

    return Scaffold(
      body: isLoading
          ? Center(child: Image.asset('assets/images/quizloading.gif'),)
          : SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            audio(question);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            padding: EdgeInsets.only(top: 40),
                            height: 220.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/board.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListView(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      no.toString() + '. ' + question,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 320,
                          child: ListView.builder(
                            itemCount: choices.length,
                            itemBuilder: (context, index) {
                              bool isSelected = userAnswer == choices[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    select = 'selected';
                                    audio(choices[index]);
                                    userAnswer = choices[index];
                                    play = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    SizedBox(height: 5,),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(isSelected
                                              ? 'assets/images/choices2.png'
                                              : 'assets/images/choices.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            choices[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 8, 75, 10), 
                                    ),
                                  onPressed: () {
                                    if(select != ''){
                                      if (userAnswer == answer) {
                                      String ans = "True";
                                      saveScore(ans);
                                      setState(() {
                                        score +=1;
                                      });
                                      print('Correct answer');
                                    } else {
                                      String ans = "False";
                                      saveScore(ans);
                                      print('Wrong answer');
                                    }
                                    
                                    if (num < quizDataList.length - 1) {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                        return ShowAnswerScreen(question: question, choices: choices, answer: answer, userAnswer: userAnswer);
                                      }))).then((_) {
                                        goToNextQuestion();
                                      });
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                        return ShowAnswerScreen(question: question, choices: choices, answer: answer, userAnswer: userAnswer);
                                      }))).then((_) {
                                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                        return QuizScoreScreen(
                                          userId : widget.userId,
                                          classroomID: widget.classroomID,
                                          grade: widget.grade,
                                          score: score,); 
                                      })));
                                      });
                                    }
                                    }else{
                                      audio("Please choose an answer");
                                      EasyLoading.showError("Please choose an answer");
                                    }
                                  },
                                  child: Text('NEXT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
