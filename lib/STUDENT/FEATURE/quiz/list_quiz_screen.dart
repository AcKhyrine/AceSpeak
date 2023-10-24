import 'package:acespeak/STUDENT/FEATURE/quiz/start_quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../MAIN FEATURE/student_classroom.dart';

class Quizzes extends StatefulWidget {
  final String userId;
  final String grade;
  final String classroomID;

  const Quizzes({
    Key? key,
    required this.userId,
    required this.grade,
    required this.classroomID,
  }) : super(key: key);

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  String classCode = "";
  String teacherID = "";
  List<dynamic> quizData = [];
  List<String> deadline = [];
  List<String> title = [];
  List<String> status = [];
  Map<String, dynamic> completed_quiz = {};
  int overall = 0;
  String getCurrentDate() {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Upcoming'),
    Tab(text: 'Completed'),
    Tab(text: 'Past due' )
  ];

  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    quiz();
  }

  void quiz() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('classroom')
          .doc(widget.classroomID)
          .get();

      if (!snapshot.exists) {
        print('No documents found for students in classroom');
        return;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['Class Code'] != null && data['Teacher'] != null) {
        classCode = data['Class Code'];
        teacherID = data['Teacher'];
        getquiz();
        quizcompleted();
      } else {
        print('no Class Code');
      }
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void getquiz() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('classQuiz')
          .doc(teacherID + classCode)
          .get();

      if (!snapshot.exists) {
        print('Document does not exist for students in classroomQuiz');
        return;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['quiz'] != null) {
        quizData = data['quiz'];
        print(quizData);
        startquiz(quizData);
      } else {
        print('No classQuiz data found in the document');
      }
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void startquiz(quizData) async {
    if (quizData.isNotEmpty) {
      for (var item in quizData) {
        try {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection('quiz')
              .doc(item)
              .get();

          if (!snapshot.exists) {
            print('Document does not exist for students in quiz');
            continue;
          }
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          if (data['quiz'] != null) {
            overall = data['quiz'].length;
            title.add(data['title'] ?? ''); 
            deadline.add(data['deadline'] ?? ''); 
            status.add(data['status'] ?? ''); 
            print(title);
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

  void quizcompleted() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('quizScore')
        .doc(widget.userId + classCode)
        .get();

    if (!snapshot.exists) {
      print('Document does not exist for students in classroomQuiz');
      return;
    }
    setState(() {
      completed_quiz = snapshot.data() as Map<String, dynamic>;
      print(completed_quiz);
    });

  } catch (e) {
    print('Error fetching data: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    String currentDate = getCurrentDate();
    return Scaffold(
      body: Container(
        child: DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                print('back');
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return ClassRoomScreen(userId: widget.userId, grade: widget.grade, classroomID: widget.classroomID);
                  }));
                }, icon: Icon(Icons.arrow_back)),
              title: Text('Quiz'),
              bottom: TabBar(
                tabs: myTabs,
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                // Assuming this is your Column for "Upcoming" quizzes
Column(
  children: [
    if (title.isNotEmpty)
      Expanded(
        child: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            bool isCompleted = completed_quiz.containsKey(title[index]);
            DateTime quizDeadline = DateTime.parse(deadline[index]);
            DateTime now = DateTime.now();

            if (!isCompleted && quizDeadline.isAfter(now) && status[index] == "uploaded") {
              print('Upcoming: ${title[index]}');
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    if (!isLoading) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return StartQuizScreen(
                          userId: widget.userId,
                          classroomID: widget.classroomID,
                          grade: widget.grade,
                          classCode: classCode,
                          quizData: quizData[index],
                          title: title[index],
                        );
                      }));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(title[index]),
                      subtitle: Text(deadline[index]),
                    ),
                  ),
                ),
              );
            }
            // Return an empty Container for quizzes that don't match the criteria
            return Container();
          },
        ),
      ),
  ],
),

//////////////////////////////////// COMPLETED
                Column(
                  children: [
                    if (isLoading) 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset('assets/images/quizloading.gif'),
                          )
                        ],
                      ),
                    if (!isLoading && title.length > 0) 
                      Expanded(
                        child: ListView.builder(
                          itemCount: title.length,
                          itemBuilder: (context, index) {
                            bool isCompleted = completed_quiz.containsKey(title[index]);
                            if(!isCompleted && completed_quiz[title[index]] == null){
                              print('not completed');
                            }else{
                              print('completed');
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  title: Text(title[index]),
                                  subtitle: Text(deadline[index]),
                                  trailing: Text(completed_quiz[title[index]].toString()+'/'+ completed_quiz["_about sounds"].length.toString())
                                ),
                              ),
                            );
                            }
                          },
                        ),
                      ),
                  ],
                ),
//////////////////////////////////// PASTDUE //////////////////////////////////// 
               Column(
                children: [
                  if (isLoading)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset('assets/images/quizloading.gif'),
                        ),
                      ],
                    ),
                  if (!isLoading && title.length > 0)
                    Expanded(
                      child: ListView.builder(
                        itemCount: title.length,
                        itemBuilder: (context, index) {
                          final isCompleted = completed_quiz.containsKey(title[index]);
                          final isPastDue = DateTime.parse(deadline[index]).isBefore(DateTime.now() );

                          if (isPastDue && !isCompleted && status[index] == "uploaded") {
                            // Display past due quizzes
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  title: Text(title[index]),
                                  subtitle: Text(deadline[index]),
                                  trailing: Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            );
                          } else {
                            // Display upcoming quizzes
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
