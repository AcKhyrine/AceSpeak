import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalGameScreen extends StatefulWidget {
  final String userId;
  final String grade;
  const AnimalGameScreen({super.key, required this.userId, required this.grade});

  @override
  _AnimalGameScreenState createState() => _AnimalGameScreenState();
}

class _AnimalGameScreenState extends State<AnimalGameScreen> {
  final player = AudioPlayer();
  int currentLevel = 0;
  List<Map<String, dynamic>> levels = [
    {
      'imagePath': 'assets/game/cat.jpg',
      'correctAnswer': 'A',
      'choices': [
        {'label': 'A', 'audioPath': 'assets/sounds/cat.mp3'},
        {'label': 'B', 'audioPath': 'assets/sounds/duck.mp3'},
        {'label': 'C', 'audioPath': 'assets/sounds/pig.mp3'},
        {'label': 'D', 'audioPath': 'assets/sounds/goose.mp3'}
      ],
    },
    {
      'imagePath': 'assets/game/pig.jpg',
      'correctAnswer': 'D',
      'choices': [
        {'label': 'A', 'audioPath': 'assets/sounds/snake.mp3'},
        {'label': 'B', 'audioPath': 'assets/sounds/duck.mp3'},
        {'label': 'C', 'audioPath': 'assets/sounds/chicken.mp3'},
        {'label': 'D', 'audioPath': 'assets/sounds/pig.mp3'}
      ],
    },
    {
      'imagePath': 'assets/game/chicken.jpg',
      'correctAnswer': 'B',
      'choices': [
        {'label': 'A', 'audioPath': 'assets/sounds/cow.mp3'},
        {'label': 'B', 'audioPath': 'assets/sounds/chicken.mp3'},
        {'label': 'C', 'audioPath': 'assets/sounds/goose.mp3'},
        {'label': 'D', 'audioPath': 'assets/sounds/pig.mp3'}
      ],
    },
    {
      'imagePath': 'assets/game/strawberry.png',
      'correctAnswer': 'C',
      'choices': [
        {'label': 'A', 'audioPath': 'assets/sounds/apple.mp3'},
        {'label': 'B', 'audioPath': 'assets/sounds/pear.mp3'},
        {'label': 'C', 'audioPath': 'assets/sounds/strawberry.mp3'},
        {'label': 'D', 'audioPath': 'assets/sounds/orange.mp3'}
      ],
    },
    {
      'imagePath': 'assets/game/apple.png',
      'correctAnswer': 'B',
      'choices': [
        {'label': 'A', 'audioPath': 'assets/sounds/strawberry.mp3'},
        {'label': 'B', 'audioPath': 'assets/sounds/orange.mp3'},
        {'label': 'C', 'audioPath': 'assets/sounds/pear.mp3'},
        {'label': 'D', 'audioPath': 'assets/sounds/apple.mp3'}
      ],
    },
  ];


  String? selectedAnswer;
  bool showResult = false;

  Future<void> saveLastLevelPlayed(int level) async {
    try {
      await FirebaseFirestore.instance.collection('game').doc(widget.userId).set({
        'last_level_played': level,
      });
    } catch (e) {
      print('Error saving last level played: $e');
    }
  }

  Future<int> getLastLevelPlayed() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('game').doc('widget.userId').get();
      if (snapshot.exists) {
        final data = snapshot.data();
        return data?['last_level_played'] ?? 0;
      }
      return 0;
    } catch (e) {
      print('Error retrieving last level played: $e');
      return 0;
    }
  }

  void playSound(String audioPath) async {
    await player.stop();
    await player.setAsset(audioPath);
    await player.play();
  }

  void goToNextLevel() async {
    setState(() {
      currentLevel++;
      selectedAnswer = null;
      showResult = false;
    });
    await saveLastLevelPlayed(currentLevel);
  }

  void goToPreviousLevel() async {
    setState(() {
      currentLevel--;
      selectedAnswer = null;
      showResult = false;
    });
    await saveLastLevelPlayed(currentLevel);
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showResult = true;

      if (selectedAnswer == levels[currentLevel]['correctAnswer']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Correct!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (currentLevel < levels.length - 1) {
                      goToNextLevel();
                    }
                  },
                  child: Text('Next Level'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    replayLevel();
                  },
                  child: Text('Replay Level'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Wrong!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    replayLevel();
                  },
                  child: Text('Replay Level'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void replayLevel() async {
    setState(() {
      selectedAnswer = null;
      showResult = false;
    });
    await saveLastLevelPlayed(currentLevel);
  }

  void resetLevels() async {
    setState(() {
      currentLevel = 0;
      selectedAnswer = null;
      showResult = false;
    });
    await saveLastLevelPlayed(currentLevel);
  }

  @override
  void initState() {
    super.initState();
    getLastLevelPlayed().then((level) {
      setState(() {
        currentLevel = level;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLevel >= levels.length) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Congratulations! You completed all levels.'),
              ElevatedButton(
                onPressed: () => resetLevels(),
                child: Text('Restart Levels'),
              ),
            ],
          ),
        ),
      );
    }

    final currentLevelData = levels[currentLevel];

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                currentLevelData['imagePath'],
              ),
              Column(
                children: [
                  for (var choice in currentLevelData['choices'])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => checkAnswer(choice['label']),
                          child: Text(choice['label']),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () => playSound(choice['audioPath']),
                          icon: Icon(Icons.volume_up_rounded),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              if (showResult)
                Text(
                  selectedAnswer == currentLevelData['correctAnswer'] ? 'Correct!' : 'Wrong!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == currentLevelData['correctAnswer']
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentLevel > 0)
              ElevatedButton(
                onPressed: () => goToPreviousLevel(),
                child: Text('Previous Level'),
              ),
            ElevatedButton(
              onPressed: () => resetLevels(),
              child: Text('Restart Levels'),
            ),
          ],
        ),
      ),
    );
  }
}
