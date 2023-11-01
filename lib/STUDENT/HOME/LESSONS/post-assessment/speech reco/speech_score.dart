import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../map_screen.dart';
class SpeechPost_Assessment_Score extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String docId;
  final String pre_assessment;
  const SpeechPost_Assessment_Score({
    Key? key,
    required this.userId,
    required this.grade,
    required this.lesson,
    required this.docId,
    required this.pre_assessment,
  }) : super(key: key);

  @override
  _SpeechPost_Assessment_ScoreState createState() => _SpeechPost_Assessment_ScoreState();
}

class _SpeechPost_Assessment_ScoreState extends State<SpeechPost_Assessment_Score> {
  final FlutterTts flutterTts = FlutterTts();
  List<String> words =[];
  List<int> scores =[];
  int average = 0;
  int n = 0;
  @override
  void initState() {
    super.initState();
    fetchResults();
    fetchLesson();
  }
  int flag = 0;

  void Added() async {
    int? n = int.tryParse(widget.pre_assessment);
    if(n! >= flag){
      print('true');
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId+widget.grade)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                  'number': FieldValue.increment(1),
                });
            print('Document updated successfully.');
        } else {
          print('No documents found for the user ID: ${widget.userId}');
        }
        
      } catch (e) {
        print('Error updating document: $e');
      }
    }
    else{
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId+widget.grade)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          if (!data.containsKey('finished') || !data['finished'].contains(widget.lesson)) {
            await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                  'finished': FieldValue.arrayUnion([widget.lesson]),
                });
            print('Document updated successfully.');
          } else {
            print('Lesson already marked as finished.');
          }
        } else {
          print('No documents found for the user ID: ${widget.userId}');
        }
      } catch (e) {
        print('Error updating document: $e');
      }
    }
  }


 Future<void> fetchLesson() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .doc(widget.docId)
        .get();

    if (!snapshot.exists) {
      print('No documents found');
      return;
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      String pre = 'post-assessment' + widget.pre_assessment;
      words = (data[pre] as List<dynamic>?)?.cast<String>() ?? [];
      setState(() {});
    }
  } catch (e) {
    print('Error fetching lesson data: $e');
  }
}

Future<void> fetchResults() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(widget.userId+widget.grade)
        .get();

    if (!snapshot.exists) {
      print('No documents found 2');
      return;
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      flag = data['number'];
      Added();
      scores = (data[widget.lesson + ' lesson'] as List<dynamic>?)
        ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
        ?.toList()
        ?.reversed
        ?.toList() ?? [];

      int sum = 0;
      print(scores);
      for (int i = 0; i < scores.length; i++) {
        sum += scores[i];
      }
      setState(() {
        average = (sum / 10).toInt(); 
      });
      
    }
  } catch (e) {
    print('Error fetching results data: $e');
  }
}



void scoreDetails() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Column(
            children: [
              Text(
                "Post Assessment Results",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "To hear the proper pronunciation, click the word.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Text('Score: $average'),
            ],
          ),
        ),
content: SingleChildScrollView(
  child: Container(
    height: 200,
    child: ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        var isWrong = scores[index] < 60;
        final textColor = isWrong ? Colors.red : Colors.green;
        n = index + 1;

        return GestureDetector(
          onTap: () async {
            await flutterTts.setLanguage("en-US");
            await flutterTts.setPitch(1);
            await flutterTts.setSpeechRate(0.50);
            await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
            await flutterTts.speak(word);
          },
          child: Row(
            children: [
              Expanded(
                flex: 5, 
                child: Text(
                  '$n. $word',
                  style: TextStyle(color: textColor),
                ),
              ),
              Spacer(), 
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(scores[index].toString(), style: TextStyle(color: textColor),),
                    Icon(Icons.volume_up, color: textColor),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  ),
),


        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text('Lesson ' + widget.lesson, style: TextStyle(color: Color.fromARGB(255, 44, 151, 48), fontSize: 25, fontWeight: FontWeight.bold),)),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 20),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      average >= 40 ? Icons.star : Icons.star_border_outlined,
                      size: 80,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        average <= 55 && average > 40
                            ? Icons.star_half_outlined
                            : average > 55
                                ? Icons.star
                                : Icons.star_border_outlined,
                        size: 80,
                        color: Colors.yellow,
                      ),
                    ),
                    Icon(
                      average <= 85 && average > 70
                          ? Icons.star_half_outlined
                          : average > 85
                              ? Icons.star
                              : Icons.star_border_outlined,
                      size: 80,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                Center(
                  child: Text(
                        average! >= 90 && average <= 100
                            ? 'Excellent'
                            : average >= 80 && average < 90
                                ? 'Very Good'
                                : average >= 70 && average < 80
                                    ? 'Good'
                                    : average >= 60 && average < 70
                                        ? 'Fair'
                                        : 'Poor',
                        style: TextStyle(
                          fontSize: 25,
                          color: average > 60 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return MapScreen(
                        userId: widget.userId,
                        grade: widget.grade,
                      );
                    }));
                  },
                  child: Text('Done'),
                ),
                TextButton(onPressed: (){
                  scoreDetails();
                }, child: Text('Score Results', style: TextStyle(color: Colors.green),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
