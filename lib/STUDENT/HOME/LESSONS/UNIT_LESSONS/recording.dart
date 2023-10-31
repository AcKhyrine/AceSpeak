import 'dart:convert';
import 'dart:io';
import 'package:acespeak/STUDENT/HOME/LESSONS/UNIT_LESSONS/score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import 'lessons.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


class Recording extends StatefulWidget {
  final Function onUploadComplete;
  final String userId;
  final String grade;
  final String lesson;
  int index;
  final int number;
  final String words;
  final String item;
  Recording({
    Key? key,
    required this.onUploadComplete,
    required this.userId, required this.item, required this.words, required this.grade, required this.lesson, required this.index, required this.number
  }) : super(key: key);

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  late AudioPlayer _audioPlayer;
  late Record _recording;
  String _downloadURL = '';
  bool _isPlaying = false;
  bool _isUploading = false;
  bool _isRecorded = false;
  bool _isRecording = false;
  String _filePath = '';
  List<String> overall = [];
  List<String>spell = [];
  List<String> phonic = [];
  final String appKey = "16939684470001d2";
  final String secretKey = "14c646774d681c1e81c871fc2b1a7375";
  final String userId = "uid";
  final String baseHOST = "api.speechsuper.com";

  final String coreType = "sent.eval";
  final audioType = "wav";
  TextEditingController resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _recording = Record();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> myList = ['sheep', 'zebra', 'tiger', 'cheetah', 'behance', 'fox', 'dog', 'ball', 'bird'];
    List<String> myList = ['sheep', 'elephant', 'ball',];
    myList.shuffle();
    return Center(
      child: _isRecorded
              ? _isUploading
                  ? 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset('assets/images/'+myList[1]+'.gif', height: 70,),
                      ),
                      LinearProgressIndicator(),
                      Text('Loading.... Please wait'),
                    ],
                  )
                  : Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 2, 
                  color: const Color.fromARGB(255, 114, 114, 114), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                         GestureDetector(
                            onTap: () {
                              _onRecordAgainButtonPressed();
                            },
                            child: Image.asset('assets/images/replay.png', width: 90),
                          ),
                         GestureDetector(
                            onTap: () {
                              _onPlayButtonPressed();
                            },
                            child: Image.asset(_isPlaying ? 'assets/images/pause.png' : 'assets/images/play2.png' , width: 90),
                          ),
                          GestureDetector(
                            onTap: () {
                               _onFileUploadButtonPressed();
                            },
                            child: Image.asset('assets/images/next.png', width: 90),
                          ),
                        ],
                      ),
                    ],
                  )
            :  Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 2,
                  color: const Color.fromARGB(255, 114, 114, 114), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isRecording
                        ? GestureDetector(
                            onTap: () {
                              _onRecordButtonPressed();
                            },
                            child: Image.asset('assets/images/pause.png', width: 90),
                          )
                        : GestureDetector(
                            onTap: () {
                              _onRecordButtonPressed();
                            },
                            child: Image.asset('assets/images/play.png', width: 90),
                          ),
                        ],
                      ),
                    ],
                    
                  )
                );
              }

  Future<void> _onFileUploadButtonPressed() async {
    setState(() {
      _isUploading = true;
    });

    try {
      // bool? shouldProceed = await _showConfirmationDialog();
        final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        Reference ref = firebaseStorage
            .ref('student-record')
            .child(_filePath.substring(_filePath.lastIndexOf('/')));

        TaskSnapshot uploadTask = await ref.putFile(File(_filePath));
        _downloadURL = await uploadTask.ref.getDownloadURL();

        await doEval();
        Dialog();
        setState(() {
          _isRecorded = false;
          _isRecording = false;
          _isUploading = false;
        });

        // EasyLoading.showSuccess('File uploaded successfully');
        print(_downloadURL);
    } catch (error) {
      print('Error occurred while uploading to Firebase ${error.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred while uploading'),
        ),
      );
      setState(() {
        _isUploading = false;
      });
    }
  }

  void Dialog()async{
    int addvalue = widget.index +=1 ;
      await FirebaseFirestore.instance
      .collection('score')
      .doc(widget.userId+ widget.grade)
      .update({
        widget.item: addvalue,
      });
     Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return LessonScore(score : resultController.text,  spell:spell, overall: overall, phonic:phonic, userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index: addvalue, number: widget.number, item: widget.item);
          })));
      // Navigator.push(context, MaterialPageRoute(builder: (ctx){
      //    return Lesson_Screen(userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index: widget.index, number: widget.number, item: widget.item,);
      //   }));
        

    
    // String resultText = resultController.text;
    // int resultInt = int.tryParse(resultText) ?? 0;
    // print(resultInt);
    // showDialog(
    //   context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         contentPadding: EdgeInsets.all(5),
    //         title: resultInt >= 91 && resultInt <= 100
    //           ? Center(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset('assets/emoji/excellent.png', width: 70,),
    //                 Text('Excellent')
    //               ],
    //             ),
    //           )
    //           : resultInt >= 81 && resultInt <= 90
    //           ? Center(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset('assets/emoji/good.png', width: 70,),
    //                 Text('Very Good')
    //               ],
    //             ),
    //           )
    //           : resultInt >= 71 && resultInt <= 80
    //           ? Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Image.asset('assets/emoji/average.png', width: 70,),
    //               Text('Good')
    //             ],
    //           )
    //           : resultInt >= 61 && resultInt <= 70
    //           ? Center(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset('assets/emoji/fair.png', width: 70,),
    //                 Text('Fair')
    //               ],
    //             ),
    //           )
    //           : resultInt >= 0 && resultInt <= 60
    //           ? Center(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset('assets/emoji/poor.png', width: 70,),
    //                 Text('Poor')
    //               ],
    //             ),
    //           )
    //           : Text('Error Range'),
    //         content: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text('Phoneme-level Results'),
    //             Row(
    //               children: [
    //                 Column(
    //                   children: [
    //                     Text('Spelling'),
    //                     ...spell.map((word) => Text(word)).toList(),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text('Sound'),
    //                     ...phonic.map((phonic) => Text(phonic)).toList(),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text('Score'),
    //                     ...overall.map((overall) => Text(overall)).toList(),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //               onPressed: () async{
    //                 int addvalue = widget.index +=1 ;
    //                 await FirebaseFirestore.instance
    //                   .collection('score')
    //                   .doc(widget.userId)
    //                   .update({
    //                     widget.item: addvalue,
    //                   });
    //                 if(widget.index == 11){
    //                   await FirebaseFirestore.instance
    //                   .collection('score')
    //                   .doc(widget.userId)
    //                   .update({
    //                     'finished': FieldValue.arrayUnion([widget.item]),
    //                 });
    //                 Navigator.push(context, MaterialPageRoute(builder: (ctx) {
    //                   return MapScreen(
    //                     userId: widget.userId, grade: widget.grade);
    //                 }));
    //                 }
    //                 else{
    //                   Navigator.push(context, MaterialPageRoute(builder: (ctx){
    //                     return Lesson_Screen(userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index: widget.index, number: widget.number, item: widget.item,);
    //                   }));
    //                 }
    //               },
    //               child: Text('Next'),
    //             ),
    //         ],
    //       );
    //       },
    //   );
  }


  Future<void> doEval() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String connectSig = sha1
        .convert(utf8.encode("${appKey}${timestamp}${secretKey}"))
        .toString();
    String startSig = sha1
        .convert(utf8.encode("${appKey}${timestamp}${userId}${secretKey}"))
        .toString();
    String tokenId = DateTime.now().millisecondsSinceEpoch.toString();
    var params = {
      "connect": {
        "cmd": "connect",
        "param": {
          "sdk": {
            "version": 16777472,
            "source": 9,
            "protocol": 2,
          },
          "app": {
            "applicationId": appKey,
            "sig": connectSig,
            "timestamp": timestamp,
          },
        },
      },
      "start": {
        "cmd": "start",
        "param": {
          "app": {
            "applicationId": appKey,
            "sig": startSig,
            "userId": userId,
            "timestamp": timestamp,
            "agegroup": 2,
          },
          "audio": {
            "audioType": audioType,
          },
          "request": {
            "refText": widget.words,
            "tokenId": tokenId,
            "dict_dialect": "en_us",
          },
        },
      },
    };

    try {
      http.Response httpResponse = await http.get(Uri.parse(_downloadURL));
      if (httpResponse.statusCode == 200) {
        Uint8List audioData = httpResponse.bodyBytes;

        var url = Uri.https(baseHOST, coreType);
        var request = http.MultipartRequest("POST", url)
          ..fields["text"] = jsonEncode(params)
          ..files.add(http.MultipartFile.fromBytes("audio", audioData))
          ..headers["Request-Index"] = "0";

        var response = await request.send();
        if (response.statusCode != 200) {
          resultController.text = "HTTP status code ${response.statusCode}";
        } else {
          var str = await response.stream.transform(utf8.decoder).join();
          if (str.contains("error")) {
            resultController.text = str;
          } else {
            var respJson = jsonDecode(str);
            resultController.text = "${respJson["result"]["overall"]}";
            // resultController.text = "overall: ${respJson["result"]["pronunciation"]}";
            print(resultController.text);
            print('${respJson["result"]}');

            List<dynamic> wordsList = respJson["result"]["words"];
        
            // Iterate through words and access their phonics
            for (var wordData in wordsList) {
              List<dynamic> phonicsList = wordData["phonics"];
              for (var phonics in phonicsList) {
                overall.add(phonics["overall"].toString());
                phonic.add(phonics["phoneme"].toString());
                spell.add(phonics["spell"].toString());
              }
            }
              print(overall);
              print(phonic);
              print(spell);
          }
        }
      } else {
        resultController.text = "Failed to fetch audio from URL.";
      }
    } catch (error) {
      resultController.text = "Error while processing the API request: $error";
    }
  }

  void _onRecordAgainButtonPressed() {
    setState(() {
      _isRecorded = false;
    });
  }

  Future<void> _onRecordButtonPressed() async {
    if (_isRecording) {
      await _recording.stop();
      _isRecording = false;
      _isRecorded = true;
    } else {
      _isRecorded = false;
      _isRecording = true;

      await _startRecording();
    }
    setState(() {});
  }

  void _onPlayButtonPressed() async {
    if (!_isPlaying) {
      _isPlaying = true;

      await _audioPlayer.setFilePath(_filePath);
      await _audioPlayer.play();
      _audioPlayer.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    } else {
      _audioPlayer.stop();
      _isPlaying = false;
    }
    setState(() {});
  }

  Future<void> _startRecording() async {
    final bool hasRecordingPermission = await _recording.hasPermission();
    if (hasRecordingPermission) {
      Directory directory = await getApplicationDocumentsDirectory();
      String filepath = path.join(directory.path,
          '${DateTime.now().millisecondsSinceEpoch.toString()}.wav');
      await _recording.start(
        path: filepath,
        encoder: AudioEncoder.wav,
        bitRate: 128000,
        samplingRate: 16000,
        numChannels: 1,
      );
      _filePath = filepath;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text('Please enable recording permission'))));
    }
  }
}
