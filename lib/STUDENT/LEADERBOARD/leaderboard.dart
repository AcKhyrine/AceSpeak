import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List<String> student = [];
  Map<String, int> studentScores = {};
  
  @override
  void initState() {
    super.initState();
    students();
  }

  void students() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();
    if (snapshot.docs.isEmpty) {
      print('No documents found for students in user collection');
      return;
    }
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      student.add(doc.id);
    }
    StudentName();
    print(student);
    setState(() {});
  } catch (e) {
    print('Error fetching data: $e');
  }
}


  void StudentName() async {
    for (int i = 0; i < student.length; i++) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(student[i])
            .get();

        if (!snapshot.exists) {
          print('No documents found for students in user collection');
          return;
        }
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data['Firstname'] != null && data['Lastname'] != null) {
          var studentName = data['Firstname'] + ' ' + data['Lastname'];
          studentScores[studentName] = await StudentScore(i); 
        }
        setState(() {});
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<int> StudentScore(int i) async {
  int total = 0;
  total = await StudentScore1(i) +
          await StudentScore2(i) +
          await StudentScore3(i) +
          await StudentScore4(i) +
          await StudentScore5(i) +
          await StudentScore6(i);
  return total;
}


//Grade 1
  Future<int> StudentScore1(int i) async {
    
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 1')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 2
  Future<int> StudentScore2(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 2')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 3
  Future<int> StudentScore3(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 3')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
     int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 4
  Future<int> StudentScore4(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 4')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 5
  Future<int> StudentScore5(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 5')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
     int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 6
  Future<int> StudentScore6(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 6')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
    int average, score1 = 0, score2 = 0, score3 = 0, score4 = 0, score5 = 0, score6 = 0, score7 = 0, score8 = 0, score9 = 0, score10 = 0, score11 = 0, score12 = 0, score13 = 0, score14 = 0, score15 = 0, score16 = 0, score17 = 0, score18 = 0, score19 = 0, score20 = 0;
    //lesson 1
      if(data['1-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score1 = score1 > averageScore ? score1 : averageScore;
                }
              }
            }
          });
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score2 = score2 > averageScore ? score2 : averageScore;
                }
              }
            }
          });
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score3 = score3 > averageScore ? score3 : averageScore;
                }
              }
            }
          });
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score4 = score4 > averageScore ? score4 : averageScore;
                }
              }
            }
          });
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('1-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score5 = score5 > averageScore ? score5 : averageScore;
                }
              }
            }
          });
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score6 = score6 > averageScore ? score6 : averageScore;
                }
              }
            }
          });
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score7 = score7 > averageScore ? score7 : averageScore;
                }
              }
            }
          });
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score8 = score8 > averageScore ? score8 : averageScore;
                }
              }
            }
          });
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score9 = score9 > averageScore ? score9 : averageScore;
                }
              }
            }
          });
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('2-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score10 = score10 > averageScore ? score10 : averageScore;
                }
              }
            }
          });
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score11 = score11 > averageScore ? score11 : averageScore;
                }
              }
            }
          });
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score12 = score12 > averageScore ? score12 : averageScore;
                }
              }
            }
          });
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score13 = score13 > averageScore ? score13 : averageScore;
                }
              }
            }
          });
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score14 = score14 > averageScore ? score14 : averageScore;
                }
              }
            }
          });
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('3-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score15 = score15 > averageScore ? score15 : averageScore;
                }
              }
            }
          });
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-1 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score16 = score16 > averageScore ? score16 : averageScore;
                }
              }
            }
          });
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-2 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score17 = score17 > averageScore ? score17 : averageScore;
                }
              }
            }
          });
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
       data.keys.forEach((key) {
            if (key.startsWith('4-3 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score18 = score18 > averageScore ? score18 : averageScore;
                }
              }
            }
          });
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-4 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score19 = score19 > averageScore ? score19 : averageScore;
                }
              }
            }
          });
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        data.keys.forEach((key) {
            if (key.startsWith('4-5 ') && key.endsWith(' lesson')) {
              List<dynamic>? scores = data[key] as List<dynamic>?;
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
                  int averageScore = totalScore ~/ numberOfScores;
                  score20 = score20 > averageScore ? score20 : averageScore;
                }
              }
            }
          });
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

@override
Widget build(BuildContext context) {
  final sortedStudentScores = Map.fromEntries(studentScores.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value)));

  List<int> top3UniqueScores = [];
  int scoreCount = 0;

  for (var score in sortedStudentScores.values) {
    if (scoreCount >= 3) {
      break;
    }
    if (!top3UniqueScores.contains(score)) {
      top3UniqueScores.add(score);
      scoreCount++;
    }
  }

  Map<int, String> rankImages = {
    1: 'assets/images/1st.png',
    2: 'assets/images/2nd.png',
    3: 'assets/images/3rd.png',
  };
  return Scaffold(
    body: SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grass 1.png'),
            alignment: Alignment.bottomCenter,
            repeat: ImageRepeat.repeatX,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.green[800]),
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                'Leader Board',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Name', style: TextStyle(color: Colors.grey),),
                Text('Ranking', style: TextStyle(color: Colors.grey),)
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sortedStudentScores.length,
                itemBuilder: (BuildContext context, int index) {
                  final studentName = sortedStudentScores.keys.elementAt(index);
                  final studentScore = sortedStudentScores[studentName];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 20, right: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(studentName),
                        Row(
                          children: [
                            Text(studentScore.toString()),
                            if (top3UniqueScores.contains(studentScore))
                              Image.asset(
                                rankImages[top3UniqueScores.indexOf(studentScore!) + 1]!,
                                width: 30,
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}