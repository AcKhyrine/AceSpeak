import 'package:acespeak/user/welcome_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WelcomeMessage extends StatefulWidget {
  const WelcomeMessage({Key? key}) : super(key: key);

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    audio();
    super.initState();
  }

  void audio()async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak('Welcome to Ace Speak. Get ready to improve your English pronunciation and boost your confidence in speaking. Whether you\'re a beginner or an advanced learner, our speech recognition technology will help you achieve accurate and fluent pronunciation.');
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
            image: AssetImage('assets/images/frame1.png'),
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
              Column(
                children: [
                  SizedBox(
                    height: 245,
                  ),
                  Container(
                    width: 380,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Acespeak',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 2),
                        Expanded(
                          child: Text(
                            'Get ready to improve your English pronunciation and boost your confidence in speaking. Whether you\'re a beginner or an advanced learner, our speech recognition technology will help you achieve accurate and fluent pronunciation.',
                            style: TextStyle(
                              fontSize: 14.8,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      flutterTts.stop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomPageScreen()));
                    },
                    child: Text(
                      'Start Now',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
