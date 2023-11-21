import 'package:acespeak/STUDENT/PROGRESS/progress_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../HOME/student_classroom.dart';

class ProgressHistory extends StatefulWidget {
  final String userId;
  final String grade;
  final String unit;
  const ProgressHistory({ required this.userId, required this.grade, required this.unit});

  @override
  State<ProgressHistory> createState() => _ProgressHistoryState();
}

class _ProgressHistoryState extends State<ProgressHistory> {
  int score1=0, score2=0, score3=0, score4=0, score5=0, score6=0, score7=0, score8=0, score9=0, score10=0, score11=0, score12=0, score13=0, score14=0, score15=0, score16=0, score17=0, score18=0, score19=0, score20=0;
  @override
  void initState() {
    postAssessmentScore();
    super.initState();
  }

  void postAssessmentScore() async {
    try {
      String documentId = widget.userId;
      CollectionReference scoreCollection =
          FirebaseFirestore.instance.collection('score');

      DocumentSnapshot docSnapshot =
          await scoreCollection.doc(documentId+widget.grade).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
    // lesson 1 scores
          if(data['1-1 lesson'] != null && data['1-1 lesson'].length == 10){
            // List<dynamic>? scores = data['1-1 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score1 = totalScore ~/ numberOfScores;
            // } else {
            //   score1 = 0;
            // }
            // print(score1);

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
          // lesson 2 scores
          if(data['1-2 lesson'] != null && data['1-2 lesson'].length == 10){
            // List<dynamic>? scores = data['1-2 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score2 = totalScore ~/ numberOfScores;
            // } else {
            //   score2 = 0;
            // }

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
                  print(score2.toString());
                  print("=====================================");
                }
              }
            }
          });

          }  
          // lesson 3 scores
          if(data['1-3 lesson'] != null && data['1-3 lesson'].length == 10){
            // List<dynamic>? scores = data['1-3 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;
            // print('lesson 3');
            // print(scores);
            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score3 = totalScore ~/ numberOfScores;
            // } else {
            //   score3 = 0;
            // }
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
          }else{
            print('none');
          }
          // lesson 4 scores
          if(data['1-4 lesson'] != null && data['1-4 lesson'].length == 10){
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
            // List<dynamic>? scores = data['1-4 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score4= totalScore ~/ numberOfScores;
            // } else {
            //   score4 = 0;
            // }
          }  
          // lesson 5 scores
          if(data['1-5 lesson'] != null && data['1-5 lesson'].length == 10){
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
            // List<dynamic>? scores = data['1-5 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score5 = totalScore ~/ numberOfScores;
            // } else {
            //   score5 = 0;
            // }
          }  
          // lesson 6 scores
          if(data['2-1 lesson'] != null && data['2-1 lesson'].length == 10){
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
          }
          );
            // List<dynamic>? scores = data['2-1 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score6 = totalScore ~/ numberOfScores;
            // } else {
            //   score6 = 0;
            // }
          }  
          // lesson 7 scores
          if(data['2-2 lesson'] != null && data['2-2 lesson'].length == 10){
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
          } );
            // List<dynamic>? scores = data['2-2 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score7 = totalScore ~/ numberOfScores;
            // } else {
            //   score7 = 0;
            // }
          }
          // lesson 8 scores
          if(data['2-3 lesson'] != null && data['2-3 lesson'].length == 10){
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
            // List<dynamic>? scores = data['2-3 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score8 = totalScore ~/ numberOfScores;
            // } else {
            //   score8 = 0;
            // }
          }
          // lesson 9 scores
          if(data['2-4 lesson'] != null && data['2-4 lesson'].length == 10){
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
            // List<dynamic>? scores = data['2-4 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score9 = totalScore ~/ numberOfScores;
            // } else {
            //   score9 = 0;
            // }
          }
          // lesson 10 scores
          if(data['2-5 lesson'] != null && data['2-5 lesson'].length == 10){
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
            // List<dynamic>? scores = data['2-5 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score10 = totalScore ~/ numberOfScores;
            // } else {
            //   score10 = 0;
            // }
          }
          // lesson 11 scores
          if(data['3-1 lesson'] != null && data['3-1 lesson'].length == 10){
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
            // List<dynamic>? scores = data['3-1 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score11 = totalScore ~/ numberOfScores;
            // } else {
            //   score11 = 0;
            // }
          }
          // lesson 12 scores
          if(data['3-2 lesson'] != null && data['3-2 lesson'].length == 10){
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
            // List<dynamic>? scores = data['3-2 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score12 = totalScore ~/ numberOfScores;
            // } else {
            //   score12 = 0;
            // }
          }
          // lesson 13 scores
          if(data['3-3 lesson'] != null && data['3-3 lesson'].length == 10){
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
            // List<dynamic>? scores = data['3-3 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score13 = totalScore ~/ numberOfScores;
            // } else {
            //   score13 = 0;
            // }
          }
          // lesson 14 scores
          if(data['3-4 lesson'] != null && data['3-4 lesson'].length == 10){
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
            // List<dynamic>? scores = data['3-4 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score14 = totalScore ~/ numberOfScores;
            // } else {
            //   score14 = 0;
            // }
          }
          // lesson 15 scores
          if(data['3-5 lesson'] != null && data['3-5 lesson'].length == 10){
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
            // List<dynamic>? scores = data['3-5 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score15 = totalScore ~/ numberOfScores;
            // } else {
            //   score15 = 0;
            // }
          }
          // lesson 16 scores
          if(data['4-1 lesson'] != null && data['4-1 lesson'].length == 10){
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
            // List<dynamic>? scores = data['4-1 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score16 = totalScore ~/ numberOfScores;
            // } else {
            //   score16 = 0;
            // }
          }
          // lesson 17 scores
          if(data['4-2 lesson'] != null && data['4-2 lesson'].length == 10){
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
            // List<dynamic>? scores = data['4-2 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score17 = totalScore ~/ numberOfScores;
            // } else {
            //   score17 = 0;
            // }
          }
          // lesson 18 scores
          if(data['4-3 lesson'] != null && data['4-3 lesson'].length == 10){
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
            // List<dynamic>? scores = data['4-3 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score18 = totalScore ~/ numberOfScores;
            // } else {
            //   score18 = 0;
            // }
          }
          // lesson 19 scores
          if(data['4-4 lesson'] != null && data['4-4 lesson'].length == 10){
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
            // List<dynamic>? scores = data['4-4 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score19 = totalScore ~/ numberOfScores;
            // } else {
            //   score19 = 0;
            // }
          }
          // lesson 20 scores
          if(data['4-5 lesson'] != null && data['4-5 lesson'].length == 10){
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
            // List<dynamic>? scores = data['4-5 lesson'] as List<dynamic>?;
            // int totalScore = 0;
            // int numberOfScores = 0;

            // for (dynamic score in scores!) {
            //   if (score is String) {
            //     int? parsedScore = int.tryParse(score);
            //     if (parsedScore != null) {
            //       totalScore += parsedScore;
            //       numberOfScores++;
            //     } else {
            //       print('Warning: Failed to parse score $score as an integer.');
            //     }
            //   }
            // }
            // if (numberOfScores > 0) {
            //   score20 = totalScore ~/ numberOfScores;
            // } else {
            //   score20 = 0;
            // }
          }


        }
      }
    } catch (e) {
      print('Error calculating average score: $e');
    }
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print('SCORES');
    print(score1);
    print(score2);
    print(score3);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
            width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Choose.jpg'),
                  fit: BoxFit.cover, 
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.1),
                color: Colors.white,
                child: Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * .02,),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05,),
                        child: Column(
                          children: [
                            Text(widget.unit +" Scores",style: TextStyle(fontSize: screenHeight * .03, fontWeight: FontWeight.bold, color: Colors.blue),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Progress History",style: TextStyle(fontSize: screenHeight * .02, fontWeight: FontWeight.bold),),
                                IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                          color: Colors.grey,  
                          thickness: 1.0,    
                        ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: screenWidth * .03, right: screenWidth * .03),
                          child: Column(
                            children: [
                              // post-assessment 1
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * .03,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Post-Assessment 1: '),
                                            Text(score1.toString() + "%"),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            SizedBox(height: 0,),
                                            Container(
                                              width: screenWidth * .82, 
                                              height: screenHeight * .015,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: Colors.grey, 
                                              ),
                                            ),
                                            Container(
                                              width: score1 * 3, 
                                              height: screenHeight * 0.015, 
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  bottomLeft: Radius.circular(25),
                                                  topRight: Radius.circular(0), 
                                                  bottomRight: Radius.circular(0), 
                                                ),
                                                color: Colors.blue, 
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(onPressed: (){
                                        if(score1 > 0){
                                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                            return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "1-1", unit: widget.unit, post_assessment : '1');
                                          }));
                                        }else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 15,),
                               // post-assessment 2
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * .03,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Post-Assessment 2: '),
                                            Text(score2.toString()+ "%"),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            SizedBox(height: 0,),
                                            Container(
                                              width: screenWidth * .82, 
                                              height: screenHeight * .015,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: Colors.grey, 
                                              ),
                                            ),
                                            Container(
                                              width: score2 * 3, 
                                              height: screenHeight * 0.015,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  bottomLeft: Radius.circular(25),
                                                  topRight: Radius.circular(0), 
                                                  bottomRight: Radius.circular(0), 
                                                ),
                                                color: Colors.blue, 
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(onPressed: (){
                                        if(score2 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "1-2" ,unit: widget.unit, post_assessment : '2');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),            
                              SizedBox(height: 15,),
                               // post-assessment 3
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * .03,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Post-Assessment 3: '),
                                            Text(score3.toString()+ "%"),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            SizedBox(height: 0,),
                                            Container(
                                              width: screenWidth * .82, 
                                              height: screenHeight * .015,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: Colors.grey, 
                                              ),
                                            ),
                                            Container(
                                              width: score3 * 3, 
                                              height: screenHeight * 0.015, 
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  bottomLeft: Radius.circular(25),
                                                  topRight: Radius.circular(0), 
                                                  bottomRight: Radius.circular(0), 
                                                ),
                                                color: Colors.blue, 
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(onPressed: (){
                                        if(score3 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "1-3" ,unit: widget.unit, post_assessment : '3');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                               // post-assessment 4
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                      width: screenWidth * 0.8,
                                      height: screenHeight * .03,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Post-Assessment 4: '),
                                          Text(score4.toString()+ "%"),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        SizedBox(height: 0,),
                                        Container(
                                          width: screenWidth * .82, 
                                          height: screenHeight * .015,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.grey, 
                                          ),
                                        ),
                                        Container(
                                          width: score4 * 3, 
                                          height: screenHeight * 0.015, 
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              topRight: Radius.circular(0), 
                                              bottomRight: Radius.circular(0), 
                                            ),
                                            color: Colors.blue, 
                                          ),
                                        ),
                                      ],
                                    ),
                                      TextButton(onPressed: (){
                                        if(score4 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "1-4" ,unit: widget.unit, post_assessment : '4');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
            
                              SizedBox(height: 15,),
                               // post-assessment 5
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                      width: screenWidth * 0.8,
                                      height: screenHeight * .03,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Post-Assessment 5: '),
                                          Text(score5.toString()+ "%"),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        SizedBox(height: 0,),
                                        Container(
                                          width: screenWidth * .82, 
                                          height: screenHeight * .015,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.grey, 
                                          ),
                                        ),
                                        Container(
                                          width: score5 * 3, 
                                          height: screenHeight * 0.015, 
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              topRight: Radius.circular(0), 
                                              bottomRight: Radius.circular(0), 
                                            ),
                                            color: Colors.blue, 
                                          ),
                                        ),
                                      ],
                                    ),
                                      TextButton(onPressed: (){
                                        if(score5 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "1-5" ,unit: widget.unit, post_assessment : '5');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                     
                              SizedBox(height: 15,),
                              // post-assessment 6
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 6: '),
                                    Text(score6.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score6 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score6 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "2-1" ,unit: widget.unit, post_assessment : '6');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                             
                                              
                              SizedBox(height: 15,),
                              // post-assessment 7
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 7: '),
                                    Text(score7.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score7 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score7 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "2-2" ,unit: widget.unit, post_assessment : '7');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),

                              
                                              
                              SizedBox(height: 15,),
                              // post-assessment8
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 8: '),
                                    Text(score8.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score8 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score8 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "2-3" ,unit: widget.unit, post_assessment : '8');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              // post-assessment 9
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 9: '),
                                    Text(score9.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score9 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score9 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "2-4" ,unit: widget.unit, post_assessment : '9');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),

                              
                                              
                              SizedBox(height: 15,),
                               // post-assessment 10
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 10: '),
                                    Text(score10.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score10 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score10 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "2-5" ,unit: widget.unit, post_assessment : '10');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              // post-assessment 11
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 11: '),
                                    Text(score11.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score11 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score11 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "3-1" ,unit: widget.unit, post_assessment : '11');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              // post-assessment 12
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 12: '),
                                    Text(score12.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score12 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score12 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "3-2" ,unit: widget.unit, post_assessment : '12');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
           
                              SizedBox(height: 15,),
                              // post-assessment 13
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 13: '),
                                    Text(score13.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score13 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score13 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "3-3" ,unit: widget.unit, post_assessment : '13');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              // post-assessment 14
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 14: '),
                                    Text(score14.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score14 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score14 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "3-4" ,unit: widget.unit, post_assessment : '14');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                
                              SizedBox(height: 15,),
                              // post-assessment 15
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 15: '),
                                    Text(score15.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score15 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score15 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "3-5" ,unit: widget.unit, post_assessment : '15');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              // post-assessment 16
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 16: '),
                                    Text(score16.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score16 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score16 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "4-1" ,unit: widget.unit, post_assessment : '16');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                               // post-assessment 17
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 17: '),
                                    Text(score17.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score17 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                         if(score17 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "4-2" ,unit: widget.unit, post_assessment : '17');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                               // post-assessment 18
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 18: '),
                                    Text(score18.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score18 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score18 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "4-3" ,unit: widget.unit, post_assessment : '18');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              //post-assessment 19
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Asessment 19: '),
                                    Text(score19.toString()+ "%"),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score19 * 3, 
                                    height: screenHeight * 0.015, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score19 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "4-4" ,unit: widget.unit, post_assessment : '19');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                                              
                              SizedBox(height: 15,),
                              //post-assessment 20
                              Card(
                                elevation: 8.0, 
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * .05,),
                                  width: double.infinity,
                                  height: screenHeight * 0.12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * .03,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Post-Assessment 20: '),
                                    Text(score20.toString()+ "%"),
                                  ],
                                ),
                              ),
                              
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SizedBox(height: 0,),
                                  Container(
                                    width: screenWidth * .82, 
                                    height: screenHeight * .015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Container(
                                    width: score20 * 3, 
                                    height: screenHeight * 0.015,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        topRight: Radius.circular(0), 
                                        bottomRight: Radius.circular(0), 
                                      ),
                                      color: Colors.blue, 
                                    ),
                                  ),
                                ],
                              ),
                                      TextButton(onPressed: (){
                                        if(score20 > 0){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return ProgressDetails(userId: widget.userId, grade: widget.grade, lesson: "4-5" ,unit: widget.unit, post_assessment : '20');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You dont have progress to this post-assessment");
                                        }
                                        
                                      }, child: Text('View Progress',style: TextStyle(color: Colors.blue),))
                                    ],
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                          ),
              ),
            ),
            // Positioned(
            //         top: 20,
            //         right: 20,
            //         child: IconButton(
            //           icon: Icon(Icons.close),
            //           onPressed: () {
            //             Navigator.pop(context);
            //             // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            //             //   return ClassRoomScreen(userId: widget.userId);
            //             //   }));
            //           },
            //         ),
            //       ),
          ],
        )
      ),
    );
  }
}
