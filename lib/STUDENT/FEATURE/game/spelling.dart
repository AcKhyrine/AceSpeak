import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpellingGame extends StatefulWidget {
  final String userid;
  const SpellingGame({super.key, required this.userid});

  @override
  State<SpellingGame> createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final FlutterTts flutterTts = FlutterTts();
  List<String> word = ['star', 'movie', 'hand', 'ear', 'shoes', 'dog', 'house', 'woman', 'father', 'mother', 'short', 'phone', 'computer', 'moon', 'water', 'snake', 'feet', 'flower', 'green', 'plastic', 'hair', 'light', 'message', 'letter', 'zero', 'kids', 'sister', 'player', 'paper', 'plate', 'home', 'life', 'hallo', 'tooth', 'lotion', 'curtain', 'angel', 'priest', 'watch', 'candle', 'jacket', 'hammer', 'butter', 'kitten', 'picnic', 'button', 'friend', 'doctor', 'pencil', 'silver', 'forest', 'guitar', 'sunset', 'island', 'coffee', 'camera', 'orange', 'purple', 'summer', 'sweater', 'jungle', 'beauty', 'morning', 'chicken', 'pancake', 'library', 'sailing', 'holiday', 'running', 'swimming', 'chimney', 'cheese', 'heaven', 'miracle', 'victory', 'silence', 'cricket', 'dessert', 'goddess', 'history', 'bicycle', 'freedom', 'justice', 'opinion', 'kangaroo', 'penguin', 'wonder'];
  List<String> letter = ['a', 'z', 'x', 's', 'l', 'f', 'o', 'e', 'h', 'y', 'b', 'u', 'k', 'm', 'i'];
  List<String> spell =[];
  List<String> imageList = ['assets/game_spelling/correct1.gif', 'assets/game_spelling/correct2.gif', 'assets/game_spelling/correct3.gif', 'assets/game_spelling/correct4.gif', 'assets/game_spelling/correct5.gif',];
  bool image = false;
  String answer = '';
  bool isPlaying = false;
  int level = 0;
  List<String> selectAnswer = [];

  @override
  void initState() {
    super.initState();
    getWord();
  }

  void getWord()async{
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
          
          if(data['spelling'] != null){
            level = data['spelling'];
          }
          else if(data['spelling'] == null){
            level = 0;
          }
          else if(data['spelling'] >= 88){
            level = 0;
          }
          else{
            level = 0;
          }
        answer = word[level]; 
        for (int i = 0; i < answer.length; i++) {
              spell.add(answer[i]);
            }
            if(spell.length != 8){
              int num = spell.length;
              for(int i = num; i < 8; i++){
                letter.shuffle();
                spell.add(letter[i]);
                num += 1;
              }
            }
            spell.shuffle();
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void audio(word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }
  
  Future<void> updateArray() async {
    level += 1;
    try {
      final CollectionReference gameCollection = FirebaseFirestore.instance.collection('game');
      final DocumentReference userDocument = gameCollection.doc(widget.userid);
      await userDocument.update({
        'spelling': level,
      });
      setState(() {
        getWord();
      });
    } catch (e) {
      print('Error updating array: $e');
    }
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        image = !image;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    print(selectAnswer);
    imageList.shuffle();
    String display = imageList[3]; 
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: spell.length != 0 ? 
         Stack(
           children: [
             Container(
              width: double.infinity,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(height: height* 0.03,),
                  Container(
                    width: double.infinity,
                    height: height * .21,
                    margin: EdgeInsets.only(left: width * .050, right: width * .050),
                    child: Image.asset(
                      'assets/game_spelling/SPELLING.png',
                      fit: BoxFit.cover, 
                    ),
                  ),
                  Text('Play the audio, then spell the word correctly.', style: TextStyle(fontSize: height * .022,),),
                  SizedBox(height: height * .12,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        audio(answer);
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Image.asset(isPlaying ? 'assets/game_spelling/pause.png' : 'assets/game_spelling/play.png'),
                  ),
                  Container(
                    height: height * .13,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          if (index < answer.length) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (index < selectAnswer.length && selectAnswer[index].isNotEmpty) {
                                    String removedItem = selectAnswer[index];
                                    selectAnswer[index] = '';
                                    for (int i = 0; i < spell.length; i++) {
                                      if (spell[i] == '') {
                                        spell[i] = removedItem;
                                        break;
                                      }
                                    }
                                    for (int i = 0; i < selectAnswer.length; i++) {
                                      if (selectAnswer[i] == removedItem) {
                                        selectAnswer[i] = removedItem;
                                        break;
                                      }
                                    }
                                    selectAnswer.removeWhere((item) => item.isEmpty);
                                  }
                                  print(selectAnswer);
                                  print(spell);
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: width * .11,
                                    height: height * .08,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (selectAnswer == null || index >= selectAnswer.length) ? '' : selectAnswer[index] ?? '',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * .015),
                                ],
                              ),
                            );
                          } else {
                            return Row(
                              children: [
                                Container(
                                  width: width * .11,
                                  height: height * .08,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    color: Color.fromARGB(255, 30, 233, 84),
                                  ),
                                ),
                                 SizedBox(width: width * .015),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(onPressed: (){
                          if(answer.length == selectAnswer.length){
                            String select = selectAnswer.join('');
                            print(answer + select);
                            if(answer == select){
                              EasyLoading.showSuccess('You spell it correctly');
                              setState(() {
                                image = !image;
                                updateArray();
                                selectAnswer.clear();
                                spell.clear();
                              });
                            }else{
                              EasyLoading.showError('you spell it wrong');
                            }
                          }
                         }, child: Text('check')),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                              selectAnswer.add(spell[0]);
                              spell[0] ='';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[0], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                              selectAnswer.add(spell[1]);
                              spell[1] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[1], style: TextStyle(fontSize: 22),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[2]);
                            spell[2] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[2], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[3]);
                            spell[3] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[3], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[4]);
                            spell[4] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[4], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[5]);
                            spell[5] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[5], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[6]);
                            spell[6] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[6], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectAnswer.length < answer.length){
                            selectAnswer.add(spell[7]);
                            spell[7] = '';
                            }
                          });
                        },
                        child: Container(
                          color: Color.fromARGB(255, 30, 233, 84),
                          width: 70,
                          height: 60,
                          child: Center(child: Text(spell[7], style: TextStyle(fontSize: 20),)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
        ),
        Positioned(
          left: 2,
          bottom:5,
          child: Center(
             child: image ? Image.asset(display, height: 250,) : SizedBox.shrink(),
            )
          )
           ],
         )
          : Center(child: CircularProgressIndicator())
      ),
    );
  }
}