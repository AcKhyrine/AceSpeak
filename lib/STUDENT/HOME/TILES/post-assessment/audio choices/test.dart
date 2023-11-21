import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/audio%20choices/post-assessment_score.dart';
import 'package:acespeak/STUDENT/HOME/TILES/tiles_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';


class Post_Assessment_Screen1 extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
  Post_Assessment_Screen1({
    Key? key,
    required this.length,
    required this.userId,
    required this.grade,
    required this.pre_assessment,
    required this.lesson,
  }) : super(key: key);

  @override
  State<Post_Assessment_Screen1> createState() => _Post_Assessment_Screen1State();
}

class _Post_Assessment_Screen1State extends State<Post_Assessment_Screen1> {
  List<String> words = [];
  String docID = '';
  int score = 0;
  String correct = '';
  String name = '';
  List<String> selectedList =[];
  final FlutterTts flutterTts = FlutterTts();
  int selectedOption = -1;
  int flag = 0;
  int average = 0;
  String downloadURL = '';

  @override
  void initState() {
    super.initState();
    assessment();
  }

  void audio(String name) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(name);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void assessment() async {
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

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        String pre = 'post-assessment' + widget.pre_assessment;

        words = (data[pre] as List<dynamic>?)?.cast<String>() ?? [];
        getImageDownloadURL(words[widget.length - 1]);
        setState(() {});
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    // check if the pre-assessment score is higher than this level
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId + widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      flag = data['number'];
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> Score() async {
    String newScore = '0';
    print(correct);
    print(words[widget.length - 1]);
    if (correct == words[widget.length - 1]) {
      score += 1;
      newScore = '100';
    }
    
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('score').doc(widget.userId+widget.grade).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        List<String> scores = (data[widget.lesson + ' lesson'] as List<dynamic>?)?.cast<String>() ?? [];
        scores.add(newScore);

        await FirebaseFirestore.instance.collection('score').doc(widget.userId+widget.grade).update({
          widget.lesson + ' lesson': scores,
        });
      }
    } catch (e) {
      print('Error updating score: $e');
    }
  }

  void Added() async {
    int? n = int.tryParse(widget.pre_assessment);
    if(n! >= flag){
      print('true');
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId+widget.grade)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                  'number': FieldValue.increment(1),
                  'finished': FieldValue.arrayUnion([widget.lesson]),
                });
            print('Document updated successfully.');
            Average();
        } else {
          print('No documents found for the user ID: ${widget.userId}');
        }
        
      } catch (e) {
        print('Error updating document: $e');
      }
    }
    else{
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId+widget.grade)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          if (!data.containsKey('finished') || !data['finished'].contains(widget.lesson)) {
            await FirebaseFirestore.instance
                .collection('score')
                .doc(widget.userId+widget.grade)
                .update({
                  'finished': FieldValue.arrayUnion([widget.lesson]),
                });
            print('Document updated successfully.');
          } else {
            print('Lesson already marked as finished.');
          }
          Average();
        } else {
          print('No documents found for the user ID: ${widget.userId}');
        }
      } catch (e) {
        print('Error updating document: $e');
      }
    }
  }

  void Average()async{
    try {
      String documentId = widget.userId;
      CollectionReference scoreCollection =
          FirebaseFirestore.instance.collection('score');

      DocumentSnapshot docSnapshot = await scoreCollection.doc(documentId+widget.grade).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        print('${widget.lesson} lesson');
        if (data != null) {
          if (data['${widget.lesson} lesson'] != null) {
            List<dynamic>? scores =
                data['${widget.lesson} lesson'] as List<dynamic>?;

            print('Scores: $scores');
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
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

            print('Total Score: $totalScore');

            
            setState(() {
              average = (totalScore / 10).toInt();
            });

            print("passing average "+ average.toString());
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return Post_Assessment_Score1(pre_assessment: widget.pre_assessment,  docId: docID, userId: widget.userId, grade: widget.grade, lesson: widget.lesson, average: average);
            }));

          } else {
            print('No data for ${widget.lesson} lesson');
          }
        } else {
          print('Data is null');
        }
      } else {
        print('Document does not exist');
      }

      print('Average: $average');
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
    
    } 
  void Cheked()async{
    if (correct != words[widget.length - 1]) {
      String answer = words[widget.length - 1];
      await FirebaseFirestore.instance.collection('score').doc(widget.userId+widget.grade).update({
        widget.lesson +'wrong': FieldValue.arrayUnion([answer]),
    });
    }

  }

  Future<String?> getImageDownloadURL(picture) async {
     String lesson = widget.lesson.substring(0, 3);
    try {
      String pictureLower = picture.toLowerCase();
      Reference reference = FirebaseStorage.instance.ref(widget.grade+"/"+lesson+' lesson/$pictureLower.png');
      downloadURL = await reference.getDownloadURL();
      print(downloadURL);
      setState(() {});
    } catch (e) {
      setState(() {
        downloadURL = "not found";
      });
      print('Error getting image download URL: $e');
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // getImageDownloadURL(words[widget.length - 1]);
    name = widget.length <= words.length ? words[widget.length - 1] : '';
    selectedList = allLists[name] ?? [];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg3.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: widget.length <= words.length
              ? Stack(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Text(widget.length.toString() + ' / 10', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                        Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 2.0,
                            ),
                          ),
                          child: downloadURL != '' && downloadURL != "not found"
                                    ? Image.network(downloadURL)
                                    : downloadURL == "not found"
                                      ? Center(child: Text("Image not found"))
                                      : Center(child: Image.asset('assets/L1.gif')),
                          // Image.asset('assets/lessons/' +
                          //     widget.lesson  +
                          //     ' lesson/' +
                          //     words[widget.length - 1] +
                          //     '.png', ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            words[widget.length - 1],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50, top: 12, ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 40,
                                    decoration: BoxDecoration(
                                    color: selectedOption == 0 ? Color.fromARGB(255, 6, 44, 7) : Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20), 
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                        selectedOption = 0;
                                        correct = selectedList[selectedOption];
                                        // audio(selectedList[selectedOption]);
                                      });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('A', style: TextStyle(color: selectedOption == 0 ? Colors.white : Colors.black),),
                                          // Icon(Icons.volume_up, color: selectedOption == 0 ? Colors.white : Colors.black,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      audio(selectedList[0]);
                                    },
                                    child: Image.asset('assets/images/loud.png'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 40,
                                    width: 180,
                                    decoration: BoxDecoration(
                                    color: selectedOption == 1 ? Color.fromARGB(255, 6, 44, 7) : Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20), 
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                        selectedOption = 1;
                                        correct = selectedList[selectedOption];
                                        // audio(selectedList[selectedOption]);
                                      });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('B', style: TextStyle(color: selectedOption == 1 ? Colors.white : Colors.black),),
                                          // Icon(Icons.volume_up, color: selectedOption == 1 ? Colors.white : Colors.black)
                                        ],
                                      )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      audio(selectedList[1]);
                                    },
                                    child: Image.asset('assets/images/loud.png'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 40,
                                    width: 180,
                                    decoration: BoxDecoration(
                                    color: selectedOption == 2 ? Color.fromARGB(255, 6, 44, 7) : Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20), 
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                        selectedOption = 2;
                                        correct = selectedList[selectedOption];
                                        // audio(selectedList[selectedOption]);
                                      });
                                      },
                                      child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('C', style: TextStyle(color: selectedOption == 2 ? Colors.white : Colors.black),),
                                        // Icon(Icons.volume_up, color: selectedOption == 2 ? Colors.white : Colors.black)
                                      ],
                                    )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      audio(selectedList[2]);
                                    },
                                    child: Image.asset('assets/images/loud.png'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 40,
                                    width: 180,
                                    decoration: BoxDecoration(
                                    color: selectedOption == 3 ? Color.fromARGB(255, 6, 44, 7) : Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20), 
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                        selectedOption = 3;
                                        correct = selectedList[selectedOption];
                                        // audio(selectedList[selectedOption]);
                                      });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('D', style: TextStyle(color: selectedOption == 3 ? Colors.white : Colors.black),),
                                          // Icon(Icons.volume_up, color: selectedOption == 3 ? Colors.white : Colors.black)
                                        ],
                                      )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      audio(selectedList[3]);
                                    },
                                    child: Image.asset('assets/images/loud.png'))
                                ],
                              ),
                            ],
                          ),
                        ),
      
                        Padding(
                          padding: const EdgeInsets.only(left: 55, right: 55, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                            onPressed: () async {
                                Cheked();
                                if(selectedOption != -1){
                                Score();
                                if (widget.length < 10) {
                                  widget.length += 1;
                                  getImageDownloadURL(words[widget.length - 1]);
                                } else {
                                  print('All words displayed.');
                                  Added();
                                }
                                selectedOption = -1;
                              }else{
                                EasyLoading.showError("Please select an answer.");
                              }
                              
                              setState(() {});
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 16, 85, 19)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            child: Text('NEXT', style: TextStyle(color: Colors.white),),
                          ),
                            ],
                          ),
                        )
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
                              userId: widget.userId, grade: widget.grade);
                            }));
                        },
                      ),
                    ),
                ],
              )
              : Image.asset('assets/L2.gif'),
        ),
      ),
    );
  }

  Map<String, List<String>> allLists = {
    //Grade 1
    'Sun' : ['Sun','Soon','cun','Sum'],
    'Bug' : ['Boog','Bug','vug','Beg'],
    'Egg' : ['Emge','Elge','Egg','Ege'],
    'Pie' : ['Vie','Rie','Pee','Pie'],
    'Arm' : ['Arm','Arme','larm','Am'],
    'Rat': ['Ram', 'Ral', 'Rat', 'Ray'],
    'Bag' : ['Bang', 'Fag', 'Pag', 'Bag'],
    'Boy' : ['Booy', 'Boy', 'Moy', 'Voy'],
    'Man' : ['Man', 'Nan', 'Mam', 'Mem'],
    'Cat' : ['Caj', 'Cat', 'Cathe', 'Kite'],

    'Ball' : ['Bul', 'leb', 'Ball', 'Bell'],
    'Door' : ['Dur', 'Dar', 'Door', 'Droo'],
    'Flag' : ['Flage', 'Flange', 'Flemge', 'Flag'],
    'Sock' : ['Sock', 'sorm', 'Soke', 'Sake'],
    'Leaf' : ['Leaf', 'Laer', 'Leef', 'lif'],
    // 'House' : ['House', 'Hose', 'Huse', 'Fuse'],
    'Frog' : ['Frog', 'Fog', 'Froj', 'rog'],
    'Hand' : ['Hond', 'Hand', 'Hend', 'Hind'],
    'Duck' : ['Duck', 'Dak', 'Desk', 'Durk'],

    //Grade 2
    'Backyard' : ['Backyard','Backyord','Backyird','Backyerd'],
    'Shouted' : ['Souted', 'Shouted', 'Shoded', 'Shooted'],
    'Surprise' : ['Surpriseee', 'Sarprise', 'Surprise','Siprise'],
    'Kitchen' : ['Kisschen', 'Kimchen', 'Kitten', 'Kitchen'],
    'Mat' : ['Mat', 'Mit','Met','Nat',],
    'Table' : ['Tebel', 'Table', 'Tuble', 'Toble'],
    'Flower' : ['Flowir','Flowr','Flower','Folwer'],
    'Notebook' : ['Notebak','Notabook','Natebook','Notebook'],
    'Swing' : ['Swing','Swang','Siwing','Swong'],
    'Drum' : ['Durum', 'Drum', 'Drom', 'Drem'],

    'Singer' : ['Siner', 'Siger', 'Singar', 'Singer'],
    'Story' : ['Stary','Stormy','Story','Sory'],
    'Softdrink' : ['Sofrink','Softdrink','Softdank','Sotdrink'],
    'Barber' : ['Barber','Barvem','Barver','Baber'],
    'Broom' : ['vroom', 'Broom','room','Boom'],
    'Newspaper' : ['Nespaper','Newspoper','Newspaper','Newpaper'],
    'Kitten' : ['Kitlen', 'Ki-en', 'Citten', 'Kitten'],
    'Juice' : ['Jice', 'Juce', 'Juice', 'Guice'],
    'Chocolate' : ['Chocolale','Chocolate','Chocolite','Cocolate'],
    'Clothes' : ['Clothes','Clotes','Clothos','Clathes'],

    //Grade 3
    'House' :['House','Huse','Heouse','Hose'],
    'Tree' : ['trim', 'tre-i', 'Tree', 'try'],
    'Drink' : ['Drenk','Drunk','Drank','Drink'],
    'Color' : ['Culom', 'Color', 'Celor', 'Melor'],
    'Run' : ['Ren', 'Run', 'Ron', 'Rin'],
    'Eat' : ['Eam', 'Et', 'Eat', 'it'],
    'Dog' : ['Dog', 'Deg', 'Dig', 'Dag'],
    'Bird' : ['bard', 'Bird', 'Berd', 'Bid'],
    'Jump' : ['Jap', 'Jemp', 'Jomp', 'Jump'],
    'Teacher' : ['Teacher', 'Ticer', 'Titser', 'teethser'],

    // 'Bicycle' : ['Bycle', 'Bicycly', 'Bicycle', 'Bicle' ],
    'Elephant' : ['Elephant','elihant','Elepante','lephant'],
    'Hundred' : ['Hendred','Hundred','Hunred','Handred'],
    'Kangaroo' : ['sangaroo','Kangaree','Kangaroo','Kengaroo'],
    'Necklace' : ['Neslace','kneelace','Necklice','Necklace'],
    'Penguin' : ['Penguin', 'Peguin', 'Penuin', 'pegin'],
    'Delicious' : ['Deliciou', 'Delicious','Deticious','Dicious'],
    'Zebra' : ['Zebra','Zebar','Zeba','Lebra'],
    'Watermelon': ['Watermelom', 'Watermelon' ,'Waterfelon','Watimelon'],
    'Telephone' : ['Telephane','Talephone','Telephone','Tilephone'],

    //Grade 4
    'trees': ['rees','trise','treeses','trees'],
    'umbrellas' :['imbrellas','umbrelles','umbrillas','umbrellas'],
    'tomatoes' : ['tamatoes','tomates','tomatoes','tomatus'],
    'boxes': ['baxese','buses','boxes','boxers'],
    'table' : ['table','tible','tabel','teble'],
    'church' : ['cherch','charch','church','churche'],
    'pianos' : ['panos','pianos','pianas','pianes'],
    'windows' : ['wendews','windaws','wandows','windows'],
    'ribbon' : ['ribbon','rib-bon','rabbon','ribban'],
    'gate' :['gite','gate','gart','gote'],
    
    'wound' : ['wound','wond','woud','wand'],
    'a nice ride' : ['a rice ride','a nice ride','a nace ride','a nice rade'],
    'ride a bike': ['ride an bike','ride a bake','ride a bike','rade a bike'],
    'pine trees' : ['pire trees','pine trees','pine these','pin trees'],
    'shady lane' : ['shady lane','shay lane','shad lane','shady line'],
    'three dear': ['three dear','three lear','three deam','ree deer'],
    'beneath the sun': ['beneath those sun','beneath the sun','beneath or sun','beneath a sun'],
    'dine with wine' : ['dine with warn','dine the wine','dine with wane','dine with wine'],
    'blackberry' : ['backberry','blackverry','blackberry','blueberry'],
    'heels of the feet' : ['heels of the feet','heels of the feel','heels of the fat','heel ofs the feet'],

    //Grade 5
    'Powerful':['Powelfool', 'Powerful','pawelful', 'pawhere'],
    'Purposeful':['Purposeful', 'Poorpoful', 'Porpusiful', 'Purposefule'],
    'Successful':['Sacksespul', 'Sacispel', 'Sucsesfoole', 'Successful'],
    'Delightful':['Delathfyl', 'Deathful','Delightful', 'Dalightful'],
    'Fruitful' : ['Fruitfel', 'Fruitful','Footful','Faithful'],
    'Meaningful' :['Maminful','Meanful','Meaningful','Meaningpool'],
    'Careful':['Carefal','Carefuls','Carefully','Careful'],
    'Respectfulness': ['Resectfulness', 'Respectfulness', 'Respectpolness', 'Respectful'],
    'Resourcefulness': ['Resourcefulness', 'Resoucefulness','Reourcefulness','Resourcefuness'],
    'Sucessfulness':['Sucessfulne','Sucessfuness','Sucessfulness','Sussfulness'],

    'Chandelier': ['Chandeliez','Chandelier','Chendeleer','Chandelie'],
    'Bicycle' : ['Bycle', 'Bicycly', 'Bicycle', 'Bicle' ],
    'Geography' : ['Geography','Gegraphy','Gography','Geograph',],
    'Knowledge' : ['Knoweleeiidge','Knowlige','noledge','Knowledge'],
    'Necessarry' : ['Nacessarry','Necessar','Necessarry','Necesserry'],
    'Suspicious' :['Suspicious','Suspiciou','Suspicus','Suspicous'],
    'Yesterday' : ['Yistirday', 'Yesterday', 'Yesterdays', 'Yesterdate'],
    'Exaggerate':['Exaggerate', 'Exajerite', 'Ecagerate', 'Exarate'],
    'Beneficial' : ['Benificial', 'Beneficials', 'Benefecel', 'Binifitial'],
    'Zeppelin' : ['Zeffelin','Zeppelin','Zeppeline','Zippilin'],

    //Grade 6
    'Fox': ['Foex', 'Foxie', 'Fox', 'Fos'],
    'Bells': ['Bells', 'Bell', 'Bill', 'Beer'],
    'Brush': ['Bros', 'Bress', 'Bresh', 'Brush'],
    'Branch': ['Bras', 'Crunch', 'Brans', 'Branch'],
    'Pants': ['Parts', 'Plens', 'Pants', 'Plant'],
    'Scissors': ['Scissors', 'Scissor', 'Seeshore', 'Shisor'],
    'Piano': ['Piryano', 'Pino', 'Piano', 'Tiara'],
    'Handkerchief': ['Handsherchief', 'Handkerchief', 'Henkerchief', 'Handchief'],
    'Mosquitoes': ['Mosquitoes', 'Mokitos', 'Mostrioes', 'Mosquoes'],
    'Cactus': ['Katus', 'Actus', 'Cactus', 'Cacus'],

    'Meadow':['Meadow', 'Meaw', 'Midow', 'Mowdow'],
    'Embroidery': ['Embroivery', 'Embroibery', 'Embroidery', 'Embroudery'],
    'Grandfather': ['Grandfather', 'Godfather', 'Grandfeather', 'Groundfather'],
    'Reading': ['Reasding', 'Riding', 'Leading', 'Reading'],
    'Orchestra': ['Orchestra', 'Orhestra', 'Orbestra', 'Ochestra'],
    'Politeness': ['Politens', 'Politeness', 'Boliteness', 'Polileness'],
    'Creative': ['Creatives', 'Creates', 'Creative', 'Criaive'],
    'Painting': ['Panting', 'Pinting', 'Painting', 'Paiting'],
    'Referee': ['Referee', 'Refree', 'Refevee', 'Refereef'],
    'Infants': ['Infans', 'Infants', 'Enfents', 'Infunds'],
  };
}