import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FindObjects extends StatefulWidget {
  final String userid;
  const FindObjects({Key? key, required this.userid}) : super(key: key);

  @override
  State<FindObjects> createState() => _FindObjectsState();
}

class _FindObjectsState extends State<FindObjects> {
  List<int> game = [];
  int play = 0;
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    studentGame();
  }

  void studentGame() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('game')
          .doc(widget.userid)
          .get();

      if (!snapshot.exists) {
        print('No documents found for student in game');
        return;
      }
      Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
        game = List<int>.from(data['findObject']);
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> updateArray(int level) async {
  try {
    final CollectionReference gameCollection = FirebaseFirestore.instance.collection('game');
    final DocumentReference userDocument = gameCollection.doc(widget.userid);

    await userDocument.update({
      'findObject': FieldValue.arrayUnion([level]),
    });
  } catch (e) {
    print('Error updating array: $e');
  }
  studentGame();
  print(game);
}


  void audio(word, num) async {
    play = num;
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = screenWidth * 0.8;
    double containerHeight = screenHeight * 0.7;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Find The 50 Object That is being ask',
              style: TextStyle(
                  fontSize: screenHeight * 0.06, fontWeight: FontWeight.w400),
            ),
            Text(
              'play the audio to get a hint. Goodluck!',
              style: TextStyle(
                  fontSize: screenHeight * 0.05, fontWeight: FontWeight.w400),
            ),
            Row(
            children: [
              Container(
                width: screenWidth * 0.18,
                height: screenHeight * 0.7,
                color: const Color.fromARGB(66, 255, 193, 7),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is the biggest plant.', 1);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/game_findObjects/Houseplant.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(1) ? Icons.check : play == 1
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(1) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        )
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bedroom. It is in the bed.', 2);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .12,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/headphone.png',),
                            ),
                          ),
                          child: Icon(
                           game.contains(2) ? Icons.check : play == 2
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.19,
                            color: game.contains(2) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the couch.', 3);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/Notebook.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(3) ? Icons.check : play == 3
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(3) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the table.', 4);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/Water bottle.png',),
                            ),
                          ),
                          child: Icon(
                            game.contains(4) ? Icons.check : play == 4
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(4) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bedroom. It is in the table.', 5);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/charger.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(5) ? Icons.check : play == 5
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(5) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bedroom. It is in the pillow.', 6);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/hairbrush.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(6) ? Icons.check : play == 6
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(6) ? Color.fromARGB(255, 212, 22, 22): Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the floor.', 7);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/slippers.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(7) ? Icons.check : play == 7
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(7) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the wall.', 8);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .18,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/wallclock.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(8) ? Icons.check : play == 8
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(8) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the kitchen. It is in the table.', 9);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/mug.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(9) ? Icons.check : play == 9
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(9) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. beside the lamp.', 10);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/fan.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(10) ? Icons.check : play == 10
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(10) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bed room. It is in the bottom.', 11);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/ball.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(11) ? Icons.check : play == 11
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(11) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bed room. It is in the table.', 12);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/vase.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(12) ? Icons.check : play == 12
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(12) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the wall.', 13);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/painting.jpg'),
                            ),
                          ),
                          child: Icon(
                            game.contains(13) ? Icons.check : play == 13
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(13) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bed room. it is in the round chair .', 14);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/shoes.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(14) ? Icons.check : play == 14
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(14) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. beside the table.', 15);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/chair.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(15) ? Icons.check : play == 15
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(15) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the kitchen. It is in the cabinet.', 16);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/towel.png'),
                            ),
                          ),
                          child: Icon(
                           game.contains(16) ? Icons.check : play == 16
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(16) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bed room. It is in the chair.', 17);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/pillow.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(17) ? Icons.check : play == 17
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(17) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the kitchen window', 18);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/curtain.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(18) ? Icons.check : play == 18
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(18) ? Color.fromARGB(255, 212, 22, 22): Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is on top of chair.', 19);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/cat.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(19) ? Icons.check : play == 19
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(19) ? Color.fromARGB(255, 212, 22, 22): Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                       GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the bedroom. It is on the bed.', 20);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/telephone.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(20) ? Icons.check : play == 20
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(20) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the kitchen. It is on the ceiling.', 21);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/light.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(21) ? Icons.check : play == 21
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(21) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is on the floor.', 22);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/trophy.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(22) ? Icons.check : play == 22
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(22) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is on the floor.', 23);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/dog.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(23) ? Icons.check : play == 23
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(23) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            flutterTts.stop();
                          } else {
                            audio(
                                'You can find it in the living room. It is in the wall.', 24);
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Container(
                          height: screenHeight * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/game_findObjects/decor.png'),
                            ),
                          ),
                          child: Icon(
                            game.contains(24) ? Icons.check : play == 24
                                ? isPlaying ? Icons.pause : Icons.play_arrow
                                : Icons.play_arrow,
                            size: screenHeight * 0.2,
                            color: game.contains(24) ? Color.fromARGB(255, 212, 22, 22) : Color.fromARGB(255, 42, 195, 22),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * .02,),

///////////////////////////////////dito mo ilagay sa taas ng comment
                    ],
                  ),
                ),
              ),
                SizedBox(width: screenWidth * .01),
                Container(
                  width: containerWidth,
                  height: containerHeight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Stack(
                      children: [
                        // Background Image
                        Container(
                          width: screenWidth * 2.5,
                          height: containerHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/findObjectBg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
///////////////////////////////////////////////////////////ITATAGO////////////////////////////////////////////                        
                        Positioned(
                          left: screenWidth * 0.21,
                          bottom: screenHeight * 0.12,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(4);
                              });
                            },
                            child: game.contains(4) ? SizedBox() : Image.asset('assets/game_findObjects/Water bottle.png',
                                width: screenWidth * .06)
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.66,
                          bottom: screenHeight * 0.17,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(1);
                              });
                            },
                            child: game.contains(1) ? SizedBox() : Image.asset('assets/game_findObjects/Houseplant.png',
                                width: screenWidth * .07)
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.41,
                          bottom: screenHeight * 0.10,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(3);
                              });
                            },
                            child: game.contains(3) ? SizedBox() : Image.asset('assets/game_findObjects/Notebook.png',
                                width: screenWidth * .04) 
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.06,
                          bottom: screenHeight * 0.20,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(2);
                              });
                            },
                            child: game.contains(2) ? SizedBox() : Image.asset('assets/game_findObjects/headphone.png',
                                width: screenWidth * .04)
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.44,
                          top: screenHeight * 0.30,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(5);
                              });
                            },
                            child: game.contains(5) ? SizedBox() : Image.asset('assets/game_findObjects/charger.png',
                                width: screenWidth * .06)
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.20,
                          top: screenHeight * 0.31,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(6);
                              });
                            },
                            child: game.contains(6) ? SizedBox.shrink() : Image.asset('assets/game_findObjects/hairbrush.png',
                                width: screenWidth * .05)
                          ),
                        ),
                        Positioned(
                         left : screenWidth * 0.09,
                          bottom: screenHeight * .00001,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(7);
                              });
                            },
                            child: game.contains(7) ? SizedBox() : Image.asset('assets/game_findObjects/slippers.png',
                                width: screenWidth * .05) 
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.40,
                          top: screenHeight * 0.21,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(8);
                              });
                            },
                            child: game.contains(8) ? SizedBox() : Image.asset('assets/game_findObjects/wallclock.png',
                                width: screenWidth * .05)
                          ),
                        ),
                         Positioned(
                          right: screenWidth * 0.69,
                          bottom: screenHeight * 0.26,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(9);
                              });
                            },
                            child: game.contains(9) ? SizedBox() : Image.asset('assets/game_findObjects/mug.png',
                                width: screenWidth * .05) 
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.50,
                          bottom: screenHeight * 0.0001,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(10);
                              });
                            },
                            child: game.contains(10) ? SizedBox() : Image.asset('assets/game_findObjects/fan.png',
                                width: screenWidth * .15) 
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.01,
                          bottom: screenHeight * 0.05,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(11);
                              });
                            },
                            child: game.contains(11) ? SizedBox() : Image.asset('assets/game_findObjects/ball.png',
                                width: screenWidth * .05)
                          ),
                        ),
                         Positioned(
                          right: screenWidth * 0.355,
                          top: screenHeight * 0.23,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(12);
                              });
                            },
                            child: game.contains(12) ? SizedBox() : Image.asset('assets/game_findObjects/vase.png',
                                width: screenWidth * .10) 
                          ),
                        ),
                         Positioned(
                          left: screenWidth * 0.17,
                          top: screenHeight * 0.33,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(13);
                              });
                            },
                            child: game.contains(13) ? SizedBox() : Image.asset('assets/game_findObjects/painting.jpg',
                                width: screenWidth * .05) 
                          ),
                        ), 
                        Positioned(
                          right: screenWidth * 0.50,
                          top: screenHeight * 0.54,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(14);
                              });
                            },
                            child: game.contains(14) ? SizedBox() : Image.asset('assets/game_findObjects/shoes.png',
                                width: screenWidth * .08) 
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.01,
                          bottom: screenHeight * 0.01,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(15);
                              });
                            },
                            child: game.contains(15) ? SizedBox() : Image.asset('assets/game_findObjects/chair.png',
                                width: screenWidth * .10) 
                          ),
                        ),
                       Positioned(
                          right: screenWidth * 0.93,
                          bottom: screenHeight * 0.001,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(16);
                              });
                            },
                            child: game.contains(16) ? SizedBox() : Image.asset('assets/game_findObjects/towel.png',
                                width: screenWidth * .10) 
                          ),
                        ), Positioned(
                          right: screenWidth * 0.52,
                          bottom: screenHeight * 0.23,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(17);
                              });
                            },
                            child: game.contains(17) ? SizedBox() : Image.asset('assets/game_findObjects/pillow.png',
                                width: screenWidth * .05)
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.62,
                          bottom: screenHeight * 0.11,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(18);
                              });
                            },
                            child: game.contains(18) ? SizedBox() : Image.asset('assets/game_findObjects/curtain.png',
                                width: screenWidth * .29) 
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.90,
                          bottom: screenHeight * 0.11,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(19);
                              });
                            },
                            child: game.contains(19) ? SizedBox.shrink() : Image.asset('assets/game_findObjects/cat.png',
                                width: screenWidth * .10) 
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.25,
                          bottom: screenHeight * 0.11,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(20);
                              });
                            },
                            child: game.contains(20) ? SizedBox() : Image.asset('assets/game_findObjects/telephone.png',
                                width: screenWidth * .08)
                          ),
                        ),
                        Positioned(
                          right: screenWidth * 0.72,
                          top: screenHeight * 0.01,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(21);
                              });
                            },
                            child: game.contains(21) ? SizedBox() : Image.asset('assets/game_findObjects/light.png',
                                width: screenWidth * .08)
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.85,
                          bottom: screenHeight * 0.01,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(22);
                              });
                            },
                            child: game.contains(22) ? SizedBox() : Image.asset('assets/game_findObjects/trophy.png',
                                width: screenWidth * .03)
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.80,
                          bottom: screenHeight * 0.01,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(23);
                              });
                            },
                            child: game.contains(23) ? SizedBox() : Image.asset('assets/game_findObjects/dog.png',
                                width: screenWidth * .16)
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.73,
                          top: screenHeight * 0.19,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                updateArray(24);
                              });
                            },
                            child: game.contains(24) ? SizedBox() : Image.asset('assets/game_findObjects/decor.png',
                                width: screenWidth * .14) 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
