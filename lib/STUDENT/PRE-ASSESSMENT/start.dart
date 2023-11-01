import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'assessment_speech.dart';

class AssessmentStart extends StatefulWidget {
  final String userId;
  final String grade;
  const AssessmentStart({super.key, required this.userId, required this.grade});

  @override
  State<AssessmentStart> createState() => _AssessmentStartState();
}

class _AssessmentStartState extends State<AssessmentStart> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    audioValue();
    super.initState();
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
    if(_audio == "true"){
       audio();
    }
  }
  
  void audio()async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak('Welcome to Ace speak. Take our pronunciation test to assess your level of excellency, Good luck!');
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(children: [
                SizedBox(
                  height: 135,
                ),
                Image.asset('assets/images/logo1.png'),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 210,
                    ),
                    Container(
                      width: 380,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Welcome,',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF07883A)
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'Take our pronunciation test to assess your level of excellency, Good luck!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                flutterTts.stop();
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                                  return AssessmentSpeech(
                                      userId: widget.userId,
                                      grade : widget.grade);
                                }));
                              },
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
