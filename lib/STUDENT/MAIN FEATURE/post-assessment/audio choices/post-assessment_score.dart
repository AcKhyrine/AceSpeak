import 'package:acespeak/STUDENT/MAIN%20FEATURE/map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class Post_Assessment_Score extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final int average;
  final String classroomID;
  final String docId;
  final String pre_assessment;
  const Post_Assessment_Score({
    Key? key,
    required this.userId,
    required this.grade,
    required this.lesson,
    required this.classroomID,
    required this.docId,
    required this.pre_assessment,
    required this.average,
  }) : super(key: key);

  @override
  _Post_Assessment_ScoreState createState() => _Post_Assessment_ScoreState();
}

class _Post_Assessment_ScoreState extends State<Post_Assessment_Score> {
  final FlutterTts flutterTts = FlutterTts();
  List<String> words =[];
  List<String> wrong =[];
  int n = 0;
  @override
  void initState() {
    super.initState();
    fetchResults();
    fetchlesson();
  }

  Future<void> fetchlesson() async {
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
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchResults() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(widget.userId)
        .get();

    if (!snapshot.exists) {
      print('No documents found 2');
      return;
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      wrong = (data[widget.lesson+'wrong'] as List<dynamic>?)?.cast<String>() ?? [];
      setState(() {});
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}


  void Score_Details(){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Column(
            children: [
              Text("Post Assessment Results.", style: TextStyle(fontSize: 18, color: Colors.green[900], fontWeight: FontWeight.bold),),
              Text("To hear the proper pronunciation, click the word.", style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),
              Text('Score: ' +widget.average.toString()),
            ],
          ),
        ),
        content: Container(
          height: 200,
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              final isWrong = wrong.contains(word);
              final textColor = isWrong ? Colors.red : Colors.green;
              n = index + 1;

              return GestureDetector(
                onTap: ()async{
                  await flutterTts.setLanguage("en-US");
                  await flutterTts.setPitch(1);
                  await flutterTts.setSpeechRate(0.50);
                  await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
                  await flutterTts.speak(word);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Row(
                      children: [
                        Text(
                          n.toString() + '. ' + word,
                          style: TextStyle(color: textColor),
                        ),
                        Icon(isWrong ? Icons.close : Icons.check, color: textColor),
                      ],
                    ),
                    Icon(Icons.volume_up, color: textColor),
                  ],
                ),
              );
            },
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
                      widget.average >= 40 ? Icons.star : Icons.star_border_outlined,
                      size: 80,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        widget.average <= 55 && widget.average > 40
                            ? Icons.star_half_outlined
                            : widget.average > 55
                                ? Icons.star
                                : Icons.star_border_outlined,
                        size: 80,
                        color: Colors.yellow,
                      ),
                    ),
                    Icon(
                      widget.average <= 85 && widget.average > 70
                          ? Icons.star_half_outlined
                          : widget.average > 85
                              ? Icons.star
                              : Icons.star_border_outlined,
                      size: 80,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                Center(
                  child: Text(
                        widget.average! >= 90 && widget.average <= 100
                            ? 'Excellent'
                            : widget.average >= 80 && widget.average < 90
                                ? 'Very Good'
                                : widget.average >= 70 && widget.average < 80
                                    ? 'Good'
                                    : widget.average >= 60 && widget.average < 70
                                        ? 'Fair'
                                        : 'Poor',
                        style: TextStyle(
                          fontSize: 25,
                          color: widget.average > 60 ? Colors.green : Colors.red,
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
                        classroomID : widget.classroomID
                      );
                    }));
                  },
                  child: Text('Done'),
                ),
                TextButton(onPressed: (){
                  Score_Details();
                }, child: Text('Score Results', style: TextStyle(color: Colors.green),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
