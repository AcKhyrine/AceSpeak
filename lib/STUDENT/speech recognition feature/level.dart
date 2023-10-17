import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'lesson.dart';

class LevelScreen extends StatefulWidget {
  final String userId;
  final String grade;
  const LevelScreen({super.key, required this.userId, required this.grade});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  double average = 0;
  int level1 = 0, level2 = 0, level3 = 0;
  @override
  void initState() {
    super.initState();
    assessment();
  }

  void assessment() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        List<dynamic> assessmentArray = data['assessment'];
        level1 = data['1-5 lesson'].length;
        level2 = data['2-5 lesson'].length;
        level3 = data['3-5 lesson'].length;
        int totalScore = 0;

        for (dynamic item in assessmentArray) {
          if (item is String) {
            totalScore += int.parse(item);
          }
        }
        average = totalScore / assessmentArray.length;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (average.toInt() <= 90) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return LessonScreen(
                              userId: widget.userId,
                              grade: widget.grade,
                              level: '1');
                        }));
                      }
                    },
                    child: Text('Level 1')),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (average.toInt() <= 95 && average.toInt() >= 91) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return LessonScreen(
                            userId: widget.userId,
                            grade: widget.grade,
                            level: '2');
                      }));
                    } else if (level1 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return LessonScreen(
                            userId: widget.userId,
                            grade: widget.grade,
                            level: '2');
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete level 1 before proceeding to level 2.');
                    }
                  },
                  child: Text('Level 2'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (average.toInt() <= 96 && average.toInt() >= 98) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return LessonScreen(
                            userId: widget.userId,
                            grade: widget.grade,
                            level: '3');
                      }));
                    } else if (level2 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return LessonScreen(
                            userId: widget.userId,
                            grade: widget.grade,
                            level: '3');
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete level 2 before proceeding to level 3.');
                    }
                  },
                  child: Text('Level 3'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      EasyLoading.showInfo('not available yet');
                    },
                    child: Text('Level 4')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
