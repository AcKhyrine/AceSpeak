import 'package:acespeak/STUDENT/HOME/TILES/UNIT_LESSONS/practice.dart';
import 'package:acespeak/STUDENT/HOME/TILES/tiles_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../DICTIONARY/Model/model.dart';
import '../../../DICTIONARY/Services/service.dart';


class Lesson_Screen1 extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final int index;
  final int number;
  final String item;

  const Lesson_Screen1({
    Key? key,
    required this.userId,
    required this.item,
    required this.grade,
    required this.lesson,
    required this.index,
    required this.number,
  }) : super(key: key);

  @override
  State<Lesson_Screen1> createState() => _Lesson_Screen1State();
}

class _Lesson_Screen1State extends State<Lesson_Screen1> {
  final FlutterTts flutterTts = FlutterTts();
  String downloadURL = '';
  List<dynamic> lesson = [];
  int index = 0;
  String docID = '';
  String dictionary='';
  @override
  void initState() {
    super.initState();
    index = widget.index;
    Items();
  }

  Future<String?> getImageDownloadURL(picture) async {
    try {
      String pictureLower = picture.toLowerCase();
      print(picture);
      print(pictureLower);
      Reference reference = FirebaseStorage.instance.ref(widget.grade +'/'+widget.lesson+'/$pictureLower.png');
      downloadURL = await reference.getDownloadURL();
      print(downloadURL);
      setState(() {});
    } catch (e) {
      print('Error getting image download URL: $e');
      setState(() {
        downloadURL = "not found";
      });
      return null;
    }

    // try {
    //   Reference reference = FirebaseStorage.instance.ref('images/'+picture+'.png');
    //   downloadURL = await reference.getDownloadURL();
    //   print(downloadURL);
    //   // Reference reference =
    //   // FirebaseStorage.instance.ref('images/' + picture + '.png');
    //   //     // FirebaseStorage.instance.ref(picture + '.png');
    //   // print(picture + '.png');
    //   // downloadURL = await reference.getDownloadURL();
    //   setState(() {});
    // } catch (e) {
    //   print('Error getting image download URL: $e');
    //   return null;
    // }
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
      print('present..........................................................');
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data[widget.lesson] != null) {
        List<dynamic> lessonData = data[widget.lesson];
        lessonData.shuffle();
        while (lessonData.length < 11) {
          lessonData.addAll(data[widget.lesson]);
          lessonData.shuffle();
        }

        List<dynamic> selectedItems = lessonData.take(11).toList();
        if (selectedItems.isNotEmpty) {
          setState(() {
            lesson = selectedItems;
            getImageDownloadURL(lesson[index]);
            print(lesson[index]);
          });
        } else {
          print('Selected items list is empty');
        }
      } else {
        print('empty');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void Items() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId+widget.grade}');
        return;
      }
      print('present..........................................................');
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      index = data[widget.item];
      Introduction();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

void openDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Meaning'),
        content: Container(
          width: double.maxFinite,
          child: FutureBuilder(
            future: DictionaryService().getMeaning(word: dictionary),
            builder: (context, AsyncSnapshot<List<DictionaryModel>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Image.asset('assets/L1.gif'));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    if (data?.phonetics == null ||
                        data.phonetics!.isEmpty ||
                        data?.meanings == null ||
                        data.meanings!.isEmpty) {
                      return ListTile(
                        title: Text('Not Found'),
                      );
                    }
                    return Column(
                      children: [
                        ListTile(
                          title: Text(data.word ?? 'No Word'),
                          subtitle: Text(data.phonetics?[0]?.text ?? 'No Phonetics'),
                        ),
                        ListTile(
                          title: Text(data.meanings?[0]?.definitions?[0]?.definition ?? 'No Definition'),
                          subtitle: Text(data.meanings?[0]?.partOfSpeech ?? 'No Part of Speech'),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: Image.asset('assets/L3.gif'));
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lesson.isNotEmpty && index >= 0 && index < lesson.length
          ? Stack(
              children: [
                Image.asset(
                  'assets/images/assessment.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Column(
                  children: [
                    SizedBox(height: 150),
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
                              Text(
                                'Lesson',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            // downloadURL != ''
                                            //     ? Image.network(downloadURL)
                                            //     : Center(child: Image.asset('assets/L1.gif'))
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              if (lesson.isNotEmpty && index >= 0) {
                                                await flutterTts.setLanguage("en-US");
                                                await flutterTts.setPitch(1);
                                                await flutterTts.setSpeechRate(0.50);
                                                await flutterTts.setVoice(
                                                    {"name": "Karen", "locale": "en-AU"});
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
                                                        color: Colors.blue),
                                                  ),
                                                if (lesson.isNotEmpty && index >= 0)
                                                  Icon(
                                                    Icons.volume_up_sharp,
                                                    color: Colors.blue,
                                                  )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: 35,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    dictionary = lesson[index];
                                                    openDialog(context);
                                                  });
                                                },
                                                child: Text('see meaning'),
                                              ),
                                            ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                                                    return PracticeScreen1(
                                                        userId: widget.userId,
                                                        item: widget.item,
                                                        grade: widget.grade,
                                                        lesson: widget.lesson,
                                                        index: index,
                                                        number: widget.number,
                                                        words: lesson[index],);
                                                  }));
                                                },
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(color: Colors.white),
                                                ),
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
                        return TilesScreen(
                          userId: widget.userId,
                          grade: widget.grade,
                        );
                      }));
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Center(child: Image.asset('assets/L1.gif'))
            ),
    );
  }
}
