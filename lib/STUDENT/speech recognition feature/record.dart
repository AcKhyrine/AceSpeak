import 'dart:io';
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

class FeatureButtonsView extends StatefulWidget {
  final Function() onUploadComplete;
  final Function() moveToNextWord;
  final String level;
  final isLevelEmpty;
  final String userId;
  final String lesson;
  const FeatureButtonsView(
      {Key? key,
      required this.onUploadComplete,
      required this.moveToNextWord,
      required this.level,
      required this.isLevelEmpty,
      required this.userId,
      required this.lesson})
      : super(key: key);

  @override
  _FeatureButtonsViewState createState() => _FeatureButtonsViewState();
}

class _FeatureButtonsViewState extends State<FeatureButtonsView> {
  late AudioPlayer _audioPlayer;
  late Record _recording;
  String _downloadURL = '';
  bool _isPlaying = false;
  bool _isUploading = false;
  bool _isRecorded = false;
  bool _isRecording = false;
  String _filePath = '';

  final String appKey = "16905321330001a9";
  final String secretKey = "aba193c3ca9375c77632f6cc442f3694";
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
    return Center(
      child: widget.isLevelEmpty
          ? Text('No audio available')
          : _isRecorded
              ? _isUploading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: LinearProgressIndicator(),
                        ),
                        Text('Loading.... Please wait'),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: _onRecordAgainButtonPressed,
                        ),
                        IconButton(
                          icon:
                              Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: _onPlayButtonPressed,
                        ),
                        IconButton(
                          icon: Icon(Icons.upload_file),
                          onPressed: _onFileUploadButtonPressed,
                        ),
                      ],
                    )
              : _isRecording
                  ? IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: _onRecordButtonPressed,
                    )
                  : IconButton(
                      icon: Icon(Icons.fiber_manual_record),
                      onPressed: _onRecordButtonPressed,
                    ),
    );
  }

  Future<void> _onFileUploadButtonPressed() async {
    setState(() {
      _isUploading = true;
    });

    try {
      bool? shouldProceed = await _showConfirmationDialog();
      if (shouldProceed != null && shouldProceed) {
        final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        Reference ref = firebaseStorage
            .ref('student-record')
            .child(_filePath.substring(_filePath.lastIndexOf('/')));

        TaskSnapshot uploadTask = await ref.putFile(File(_filePath));
        _downloadURL = await uploadTask.ref.getDownloadURL();

        await doEval();
        addscore();
        widget.moveToNextWord();

        setState(() {
          _isRecorded = false;
          _isRecording = false;
          _isUploading = false;
        });

        EasyLoading.showSuccess('File uploaded successfully');
        print(_downloadURL);
      } else {
        setState(() {
          _isUploading = false;
        });
      }
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

  Future<bool?> _showConfirmationDialog() async {
    bool? shouldProceed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to upload this file?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              child: Text('Upload'),
            ),
          ],
        );
      },
    );
    return shouldProceed;
  }

  void addscore() async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('score');
      String documentId = widget.userId;
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
