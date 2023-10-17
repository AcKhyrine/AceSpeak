import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherScoreScreen extends StatelessWidget {
  const TeacherScoreScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Scores'),
      ),
      body: StudentScoresList(),
    );
  }
}

class StudentScoresList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('classroom').snapshots(),
      builder: (context, classroomSnapshot) {
        if (classroomSnapshot.hasError) {
          return Center(child: Text('Error: ${classroomSnapshot.error}'));
        }

        if (!classroomSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final classrooms = classroomSnapshot.data!.docs;

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('student').snapshots(),
          builder: (context, studentSnapshot) {
            if (studentSnapshot.hasError) {
              return Center(child: Text('Error: ${studentSnapshot.error}'));
            }

            if (!studentSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final students = studentSnapshot.data!.docs;

            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('score').snapshots(),
              builder: (context, scoreSnapshot) {
                if (scoreSnapshot.hasError) {
                  return Center(child: Text('Error: ${scoreSnapshot.error}'));
                }

                if (!scoreSnapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final scores = scoreSnapshot.data!.docs;

                return ListView.builder(
                  itemCount: classrooms.length,
                  itemBuilder: (context, index) {
                    final classroomData =
                        classrooms[index].data() as Map<String, dynamic>;
                    final grade = classroomData['Grade'];
                    final section = classroomData['Section'];

                    final studentsInClassroom = students.where((student) {
                      final studentData =
                          student.data() as Map<String, dynamic>;
                      return studentData['Grade'] == grade &&
                          studentData['Section'] == section;
                    }).toList();

                    return ExpansionTile(
                      title: Text('$grade - $section'),
                      children: studentsInClassroom.map<Widget>((student) {
                        final studentData =
                            student.data() as Map<String, dynamic>;
                        final studentId = student.id;

                        final matchingScores = scores.where((score) {
                          final scoreData =
                              score.data() as Map<String, dynamic>;
                          return scoreData['studentId'] == studentId;
                        }).toList();

                        final scoresArray = matchingScores.isNotEmpty
                            ? matchingScores[0]['scores'] as List<dynamic>
                            : [];

                        return ListTile(
                          title: Text('Student: ${studentData['Name']}'),
                          subtitle: Column(
                            children: scoresArray.map<Widget>((score) {
                              return Text('Score: $score');
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
