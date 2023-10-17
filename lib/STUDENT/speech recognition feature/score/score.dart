import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreScreen extends StatefulWidget {
  final String userId;
  final String lesson;
  const ScoreScreen({super.key, required this.userId, required this.lesson});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int _averageScore = 0;

  @override
  void initState() {
    super.initState();
    _calculateAverageScore();
  }

  Future<void> _calculateAverageScore() async {
    try {
      String documentId = widget.userId;
      CollectionReference scoreCollection =
          FirebaseFirestore.instance.collection('score');

      DocumentSnapshot docSnapshot =
          await scoreCollection.doc(documentId).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          List<dynamic>? scores = data[widget.lesson] as List<dynamic>?;
          print(scores);
          if (scores != null && scores.isNotEmpty) {
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }

            if (numberOfScores > 0) {
              _averageScore = totalScore ~/ numberOfScores;
            } else {
              _averageScore = 0;
            }
          } else {
            print('Warning: The "lesson" array is null or empty.');
            _averageScore = 0;
          }
        } else {
          print(
              'Warning: Document data is null or not in the expected format.');
          _averageScore = 0;
        }
      } else {
        print('Warning: Document does not exist.');
        _averageScore = 0;
      }

      setState(() {});
    } catch (e) {
      print('Error calculating average score: $e');
      _averageScore = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Congratulations! You completed the lesson.\n'
            'Average Score: $_averageScore'),
      ),
    );
  }
}
