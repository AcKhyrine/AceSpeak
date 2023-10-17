import 'package:acespeak/STUDENT/MAIN%20FEATURE/map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'practice.dart';

class Lesson_Screen extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final int index;
  final int number;
  final String item;
  final String classroomID;
  const Lesson_Screen({super.key, required this.classroomID, required this.userId, required this.item, required this.grade, required this.lesson, required this.index, required this.number});

  @override
  State<Lesson_Screen> createState() => _Lesson_ScreenState();
}

class _Lesson_ScreenState extends State<Lesson_Screen> {
  final FlutterTts flutterTts = FlutterTts();
  String downloadURL = '';
  List<dynamic> lesson = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    Items();
    Introduction();
  }

  Future<String?> getImageDownloadURL(picture) async {
    try {
      Reference reference = FirebaseStorage.instance.ref('images/'+picture+'.png');
      downloadURL = await reference.getDownloadURL();
      setState(() {});
    } catch (e) {
      print('Error getting image download URL: $e');
      return null; 
    }
  }

  void Introduction() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc('I7v0oFqQeVnrBR3hF9qm')
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> lessonData = data[widget.lesson];
      lessonData.shuffle();

      while (lessonData.length < 11) {
        lessonData.addAll(data[widget.lesson]);
        lessonData.shuffle();
      }

      List<dynamic> selectedItems = lessonData.take(11).toList();

      setState(() {
        lesson = selectedItems;
        getImageDownloadURL(lesson[index]);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void Items() async {
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
      index = data[widget.item];
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Image.asset(
          'assets/images/assessment.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        
        Column(
          children: [
            SizedBox(height: 170),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('Lesson',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        Divider( 
                        thickness: 1,
                        color: Color.fromARGB(255, 59, 58, 58),
                      ),
                      SizedBox(height: 10),
                      if (lesson.isNotEmpty && index >= 0) 
                        Text((index).toString() + ' / 10'),
                      if (lesson.isNotEmpty && index >= 0) 
                      Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 230,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: downloadURL != '' ? Image.network(downloadURL) 
                                  : CircularProgressIndicator()
                                  
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (lesson.isNotEmpty && index >= 0) { 
                                      await flutterTts.setLanguage("en-US");
                                      await flutterTts.setPitch(1);
                                      await flutterTts.setSpeechRate(0.50);
                                      await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
                                      await flutterTts.speak(lesson[index]);
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (lesson.isNotEmpty && index >= 0)
                                        Text(
                                          lesson[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                          ),
                                        ),
                                      if (lesson.isNotEmpty && index >= 0)
                                        Icon(Icons.volume_up_sharp, color: Colors.blue,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return PracticeScreen(userId: widget.userId, item : widget.item, grade: widget.grade, lesson: widget.lesson, index : index, number:widget.number, words : lesson[index], classroomID : widget.classroomID);
                                        }));
                                      },
                                      child: Text('Next', style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                ),
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
          ],
        ),
        Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return MapScreen(
                    userId: widget.userId, grade: widget.grade, classroomID : widget.classroomID);
                  }));
              },
            ),
          ),
      ]
    ),
      // body: Stack(
      //   children: [
      //     Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //             Container(
      //               width: 250,
      //               height: 250,
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   color: Colors.black,
      //                   width: 2.0,
      //                 ),
      //                 color: Colors.white,
      //               ),
      //               child: Image.asset(
      //                 'assets/lessons/' + widget.lesson + '/' + lesson[index] + '.png',
      //               ),
      //             ),
                
            //     SizedBox(height: 8,),
      
            //   ],
            // ),
      //     ),
      //     Positioned(
      //       top: 20,
      //       right: 20,
      //       child: IconButton(
      //         icon: Icon(Icons.close),
      //         onPressed: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      //             return MapScreen(
      //               userId: widget.userId, grade: widget.grade);
      //             }));
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}