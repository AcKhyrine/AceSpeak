import 'dart:io';
import 'package:acespeak/STUDENT/PRE-ASSESSMENT/score/assessment_score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AssessmentRecord extends StatefulWidget {
  final Function() onUploadComplete;
  final Function() moveToNextWord;
  final String level;
  final isLevelEmpty;
  final String userId;
  final String lesson;
  final String grade;
  const AssessmentRecord(
      {Key? key,
      required this.onUploadComplete,
      required this.moveToNextWord,
      required this.level,
      required this.isLevelEmpty,
      required this.userId,
      required this.grade,
      required this.lesson})
      : super(key: key);

  @override
  _AssessmentRecordState createState() => _AssessmentRecordState();
}

class _AssessmentRecordState extends State<AssessmentRecord> {
  late AudioPlayer _audioPlayer;
  late Record _recording;
  String _downloadURL = '';
  bool _isPlaying = false;
  bool _isUploading = false;
  bool _isRecorded = false;
  bool _isRecording = false;
  String _filePath = '';

final String appKey = "1700462103000227";
  final String secretKey = "97f4f017aab00e286f01bd06599d7f7f";
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
      child: widget.isLevelEmpty
          ? Text('No audio available')
          : _isRecorded
              ? _isUploading
                  ? 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset('assets/L3.gif'),
                        // child: Image.asset('assets/images/'+myList[1]+'.gif', height: 70,),
                      ),
                      // LinearProgressIndicator(),
                      // Text('Loading.... Please wait'),
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
        addscore();
        await Validation();

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

  Future<void> Validation() async{
    print('validating');
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId+widget.grade)
            .get();

          if (!snapshot.exists) {
            widget.moveToNextWord();
            print('No document found with the provided docID');
            return;
          }

          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            if (data == null || data.isEmpty) {
              print('Document data is empty');
              return;
            }

          List<dynamic> assessment = data['assessment'] as List<dynamic>;
            if (assessment == null || assessment.isEmpty) {
              print('No data found for the specified lesson level');
              return;
          }
            int totalScore = 0;
            int numberOfScores = 0;
            int averageScore = 0;
            // level 1
            if(assessment.length == 4){
              for (dynamic score in assessment) {
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
              averageScore = totalScore ~/ numberOfScores;
            } else {
              averageScore = 0;
            }              
            if(averageScore >= 85){
              widget.moveToNextWord();
            }
            else{
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 1,
                'assessment': 1
              });
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId
                    ,grade: widget.grade,);
              }));
            }
          }
          //level 2
          else if(assessment.length == 9){
              for (dynamic score in assessment) {
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
              averageScore = totalScore ~/ numberOfScores;
            } else {
              averageScore = 0;
            }              
            if(averageScore >= 85){
              widget.moveToNextWord();
            }
            else{
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 6,
                'assessment': 2
              });
              print('assessment 2...............................................');
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId,grade: widget.grade,);
              }));
            }
          }
          // level 3
          else if(assessment.length == 14){
              for (dynamic score in assessment) {
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
              averageScore = totalScore ~/ numberOfScores;
            } else {
              averageScore = 0;
            }              
            if(averageScore >= 85){
              widget.moveToNextWord();
            }
            else{
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 11,
                'assessment': 3
              });
              print('assessment 3...............................................');
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId,grade: widget.grade);
              }));
            }
          }
          //LEVEL4
          else if(assessment.length == 19 || assessment.length == 20){
            print('ending...............................................');
              for (dynamic score in assessment) {
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
              averageScore = totalScore ~/ numberOfScores;
            } else {
              averageScore = 0;
            }              
            if(averageScore >= 85){
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 16,
                'assessment': 4
              });
              print('assessment 4...............................................');
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId, grade: widget.grade);
              }));
            }
            else{
              print('averageScore < 85...............................................');
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 11,
                'assessment': 3
              });
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId,grade: widget.grade);
              }));
            }
          }
          else{
            print(assessment.length);
            if(assessment.length == 20){
              await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                'number': 16,
                'assessment': 4
              });
              print('assessment 4...............................................');
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AssessmentScoreScreen(
                    userId: widget.userId, grade: widget.grade);
              }));
            }else{
              widget.moveToNextWord();
            }
          }
  }


  void addscore() async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('score');
      String documentId = widget.userId+widget.grade;
      DocumentSnapshot snapshot = await usersCollection.doc(documentId).get();
      print(resultController.text);
      List<dynamic> newArray = [resultController.text];

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          List<dynamic>? existingArray = data[widget.lesson]?.toList();
          if (existingArray != null) {
            newArray.addAll(existingArray);
          }
        }
      }

      await usersCollection.doc(documentId).set({
        widget.lesson: newArray,
      }, SetOptions(merge: true));

      print('Value added to the array in Firestore document.');
    } catch (e) {
      print('Error updating/creating Firestore document: $e');
    }
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
            "refText": widget.level,
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
            resultController.text = "${respJson["result"]["pronunciation"]}";
            // resultController.text = "overall: ${respJson["result"]["pronunciation"]}";
            print(resultController.text);
            print('${respJson["result"]}');
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
