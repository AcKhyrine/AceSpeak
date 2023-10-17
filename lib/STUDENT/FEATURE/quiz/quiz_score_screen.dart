import 'package:flutter/material.dart';
import 'list_quiz_screen.dart';

class QuizScoreScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String classroomID;
  final int score;

  const QuizScoreScreen({
    Key? key,
    required this.userId,
    required this.grade,
    required this.classroomID,
    required this.score,
  }) : super(key: key);

  @override
  State<QuizScoreScreen> createState() => _QuizScoreScreenState();
}

class _QuizScoreScreenState extends State<QuizScoreScreen> {
  bool showConfetti = true;
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showConfetti = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Quiz Score",
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 19, 74, 21),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  minRadius: 100,
                  maxRadius: 100,
                  child: Text(
                    widget.score.toString(),
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return Quizzes(
                              userId: widget.userId,
                              classroomID: widget.classroomID,
                              grade: widget.grade,
                            );
                          }));
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showConfetti)
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  'assets/images/confetti.gif',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
