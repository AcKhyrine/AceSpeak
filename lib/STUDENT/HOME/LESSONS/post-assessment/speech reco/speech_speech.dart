import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/speech%20reco/score_load.dart';
import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/speech%20reco/speech_record.dart';
import 'package:acespeak/STUDENT/HOME/map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechRecoScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
  SpeechRecoScreen(
      {Key? key,
      required this.length,
      required this.userId,
      required this.grade,
      required this.pre_assessment,
      required this.lesson,})
      : super(key: key);

  @override
  _SpeechRecoScreenState createState() => _SpeechRecoScreenState();
}

class _SpeechRecoScreenState extends State<SpeechRecoScreen> {
  List<Reference> references = [];
  final FlutterTts flutterTts = FlutterTts();
  double speechRate = 0.50;
  List<String> level = [];
  int next = 0;
  List<String> scores =[];
  var docID;
  String downloadURL = '';
  Speak(text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(text);
  }

  void initState() {
    next = widget.length;
    // number();
    lesson();
    _onUploadComplete();
    super.initState();
  }

  Future<void> lesson() async {
    print('post-assessment' + widget.pre_assessment);
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
        print('No document found with the provided docID');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data == null || data.isEmpty) {
        print('Document data is empty');
        return;
      }
      print('post-assessment' + widget.pre_assessment);
      if (!data.containsKey('post-assessment' + widget.pre_assessment)) {
        print('No data found for the specified lesson');
        return;
      }

      List<dynamic> levelData = data['post-assessment' + widget.pre_assessment] as List<dynamic>;
      print(levelData);
      if (levelData == null || levelData.isEmpty) {
        print('No data found for the specified lesson level');
        return;
      }
      next = widget.length;
      level = List<String>.from(levelData);
      getImageDownloadURL(level[next]);
      setState(() {
      });

      print('Level data: $level');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> number() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey( widget.lesson+' lesson')) {
        setState(() {
          next = List<String>.from(data[widget.lesson+' lesson']).length;
          getImageDownloadURL(level[next]);
          print(next);
          if (next == 10) {
            print('NUMBER... END');
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return Loading_scores(
                  userId: widget.userId,
                  lesson: widget.lesson,
                  grade: widget.grade, 
                  docId: docID,
                  pre_assessment: widget.pre_assessment,
                  );
            }));
          }
        });
        print('Level data: $level');
      } else {
        print('No "level" data found in the document.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

   Future<String?> getImageDownloadURL(picture) async {
    String lesson = widget.lesson.substring(0, 3);
    print(widget.grade +'/'+lesson+"=========================================");
    try {
      String pictureLower = picture.toLowerCase();
      Reference reference = FirebaseStorage.instance.ref(widget.grade +'/'+lesson+' lesson/$pictureLower.png');
      downloadURL = await reference.getDownloadURL();
      setState(() {});
    } catch (e) {
      setState(() {
        downloadURL = "not found";
      });
      print('Error getting image download URL: $e');
      return null;
    }
    print(downloadURL+"................................................");
    // print(picture);
    // try {
    //   Reference reference = FirebaseStorage.instance.ref('images/'+picture+'.png');
    //   downloadURL = await reference.getDownloadURL();
    //   print(downloadURL);
    //   setState(() {});
    // } catch (e) {
    //   print('Error getting image download URL: $e');
    //   return null; 
    // }
    // return null;
  }

  void moveToNextWord() {
  if (level.isNotEmpty) {
    setState(() {
      next = (next + 1) % level.length;
      getImageDownloadURL(level[next]);
      if (next == 0) {
        print('MOVETONEXT.. END');
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return Loading_scores(
              userId: widget.userId,
              lesson: widget.lesson,
              grade: widget.grade,
              docId: docID,
              pre_assessment: widget.pre_assessment,
              );
        }));
      }
    });
  }
}


  Future<void> _onUploadComplete() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult =
        await firebaseStorage.ref().child('student_record').list();
    setState(() {
      references = listResult.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    int n = next +1;
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
            SizedBox(height: 140),
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
                  padding: const EdgeInsets.only(top:15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Post Assessment',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        Divider( 
                        thickness: 1,
                        color: Color.fromARGB(255, 59, 58, 58),
                      ),
                      SizedBox(height: 5,),
                      Text(n.toString()+'/10'),
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(right:18, left: 18, top: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 230,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   width: 2.0,
                                    // ),
                                    color: Colors.white,
                                  ),
                                  child: downloadURL != '' && downloadURL != "not found"
                                    ? Image.network(downloadURL)
                                    : downloadURL == "not found"
                                      ? Center(child: Text("Image not found"))
                                      : Center(child: Image.asset('assets/L1.gif')),
                                  // child: downloadURL != '' ? Image.network(downloadURL) 
                                  // : Image.asset('assets/L3.gif')
                                  // Image.asset(
                                  //   'assets/lessons/' + widget.lesson  + ' lesson/' + level[next] + '.png',
                                  // ),
                                ),
                                Text(
                                  level.isNotEmpty ? level[next] : 'Loading...',
                                  style: TextStyle(
                                    color: Color(0xFF0592F8),
                                    fontSize: 25
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SpeechAssessmentRecord(
                          grade: widget.grade,
                          onUploadComplete: _onUploadComplete,
                          moveToNextWord: moveToNextWord,
                          level: level.isNotEmpty ? level[next] : 'No data available',
                          isLevelEmpty: level.isEmpty,
                          userId: widget.userId,
                          lesson: widget.lesson,
                          docID: docID,
                          pre_assessment :widget.pre_assessment,
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
                  return MapScreen(userId: widget.userId, grade: widget.grade,);
                  }));
              },
            ),
          ),
      ]
    )
  ); 
 } 
}

