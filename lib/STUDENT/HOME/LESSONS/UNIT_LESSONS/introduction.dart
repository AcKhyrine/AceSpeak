import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../map_screen.dart';
import 'lessons.dart';

class LessonIntro extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final int index;
  final int number;
  final String item;
  const LessonIntro({super.key, required this.userId, required this.item, required this.grade, required this.lesson, required this.index, required this.number});

  @override
  State<LessonIntro> createState() => _LessonIntroState();
}

class _LessonIntroState extends State<LessonIntro> {
  final FlutterTts flutterTts = FlutterTts();
  String docID = '';
  String intro = '';
  
  @override
  void initState() {
    super.initState();
    audioValue();
    Introduction();
    print(widget.lesson);
  }
  String _audio = "true";
  void audioValue() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _audio = data['audio'];
        print(_audio+"...............................................................");
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  void Introduction() async {
    if(widget.grade == 'Grade 1'){
        docID = 'klpfg14MaQIRm5yfqk4u';
      }
      else if(widget.grade == 'Grade 2'){
        docID = 'VSqeQfpysqAkYYHhSWGA';
      }
      else if(widget.grade == 'Grade 3'){
        docID = '1sX5TLd6MXl8kQD42q43';
      }
      else if(widget.grade == 'Grade 4'){
        docID = '5hlL0bScnBpTJaPFDcWt';
      }
      else if(widget.grade == 'Grade 5'){
        docID = 'EmjyO4Qf9dBU8zYmpZct';
      }
      else if(widget.grade == 'Grade 6'){
        docID = 'I7v0oFqQeVnrBR3hF9qm';
      }
      else{
        print('check your grade level');
      }
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
         intro = data['intro ' + widget.lesson];
         if(_audio == "true"){
          audio();
         }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void audio()async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(intro);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/frame.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: (){
                      audio();
                    },
                    child: Text(
                      intro,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                            .collection('score')
                            .doc(widget.userId+widget.grade)
                            .update({
                              widget.item : 1,
                            });
                          flutterTts.stop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return Lesson_Screen(userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index: widget.index, number: widget.number, item: widget.item,);
                          }));
                          print('.............................................lesson screen');
                        },
                        child: Text('Start'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          flutterTts.stop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return MapScreen(
                                userId: widget.userId, grade: widget.grade);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}