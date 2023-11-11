import 'package:acespeak/STUDENT/HOME/LESSONS/UNIT_LESSONS/recording.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../map_screen.dart';

class PracticeScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  int index;
  final int number;
  final String words;
  final String item;
  PracticeScreen({super.key,required this.userId, required this.item, required this.words, required this.grade, required this.lesson, required this.index, required this.number});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<Reference> references = [];
  String downloadURL = '';
  @override
  void initState() {
    super.initState();
    _onUploadComplete();
    getImageDownloadURL();
  }

  Future<String?> getImageDownloadURL() async {
     try {
      String pictureLower = widget.words.toLowerCase();
      Reference reference = FirebaseStorage.instance.ref(widget.grade +'/'+widget.lesson+'/$pictureLower.png');
      downloadURL = await reference.getDownloadURL();
      print(downloadURL);
      setState(() {});
    } catch (e) {
      try{
        Reference reference = FirebaseStorage.instance.ref(widget.grade +'/'+widget.lesson+'/'+ widget.words +'.png');
        downloadURL = await reference.getDownloadURL();
        setState(() {});
      }
      catch(e){
        print('Error getting image download URL: $e');
        setState(() {
          downloadURL = "not found";
        });
        return null;
      }
    }
    // try {
    //   Reference reference = FirebaseStorage.instance.ref('images/'+widget.words+'.png');
    //   downloadURL = await reference.getDownloadURL();
    //   setState(() {});
    // } catch (e) {
    //   print('Error getting image download URL: $e');
    //   return null; 
    // }
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
                      if (widget.lesson.isNotEmpty && widget.index >= 0) 
                        Text((widget.index).toString() + ' / 10'),
                      if (widget.lesson.isNotEmpty && widget.index >= 0) 
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
                                  child: downloadURL != '' && downloadURL != "not found"
                                    ? Image.network(downloadURL)
                                    : downloadURL == "not found"
                                      ? Center(child: Text("Image not found"))
                                      : Center(child: Image.asset('assets/L1.gif')),

                                  // downloadURL != '' ? Image.network(downloadURL) 
                                  // : Center(child: Image.asset('assets/L1.gif')) 
                                  // Image.asset(
                                  //   'assets/lessons/' + widget.lesson + '/' + widget.words + '.png',
                                  // ),
                                ),
                                Text(
                                  widget.words,
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
                        flex: 2,
                        child: Recording(
                          onUploadComplete: _onUploadComplete,
                          userId: widget.userId, item : widget.item, grade: widget.grade, lesson: widget.lesson, index : widget.index, number:widget.number, words : widget.words,
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
                    userId: widget.userId, grade: widget.grade);
                  }));
              },
            ),
          ),
      ]
    )
  );
}


  Future<void> _onUploadComplete() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult =
        await firebaseStorage.ref().child('upload-voice-firebase').list();
    setState(() {
      references = listResult.items;
    });
  }

}