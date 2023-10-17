import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class EvalScreen extends StatefulWidget {
  const EvalScreen({Key? key}) : super(key: key);

  @override
  State<EvalScreen> createState() => _EvalScreenState();
}

class _EvalScreenState extends State<EvalScreen> {
  final String appKey = "16926703550001c2";
  final String secretKey = "8f6f55959f68847625dc82288d74fda1";
  final String userId = "uid";
  final String baseHOST = "api.speechsuper.com";

  final String coreType = "sent.eval"; 
  final refText = "This is just a test."; 
  final audioUrl = "https://firebasestorage.googleapis.com/v0/b/casptone-14c19.appspot.com/o/upload-voice-firebase%2F1690690872278.wav?alt=media&token=15ad9fd3-ce4d-46a3-a6c0-ec97b84cd2e1"; // Replace with the audio URL.
  final audioType = "wav"; // Change the audio type corresponding to the audio file.

  TextEditingController resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the doEval function when the screen is loaded
    doEval();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(resultController.text)
          ],
        ),
      ),
    );
  }

  void doEval() {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String connectSig = sha1.convert(utf8.encode("${appKey}${timestamp}${secretKey}")).toString();
    String startSig = sha1.convert(utf8.encode("${appKey}${timestamp}${userId}${secretKey}")).toString();
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
            "refText": refText,
            "tokenId": tokenId,
            "dict_dialect": "en_us",
          },
        },
      },
    };

    http.get(Uri.parse(audioUrl)).then((http.Response httpResponse) async {
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
          response.stream.transform(utf8.decoder).join().then((String str) {
            if (str.contains("error")) {
              resultController.text = str;
            } else {
              var respJson = jsonDecode(str);
              resultController.text = "overall: ${respJson["result"]["pronunciation"]}";
            }
          });
        }
      } else {
        resultController.text = "Failed to fetch audio from URL.";
      }
    }).catchError((error) {
      resultController.text = "Error while fetching audio from URL: $error";
    }).catchError((error) {
      resultController.text = "Error while fetching audio from URL: $error";
    });
  }
}
