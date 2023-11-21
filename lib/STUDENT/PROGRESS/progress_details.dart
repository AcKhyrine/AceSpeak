import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class ProgressDetails extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String unit;
  final String post_assessment;
  const ProgressDetails(
      {Key? key,
      required this.userId,
      required this.grade,
      required this.lesson,
      required this.unit,
      required this.post_assessment})
      : super(key: key);

  @override
  State<ProgressDetails> createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  int i = 1;
  String len = '';
  List<String> words = [];
  String docID = '';
  String present = '';
  List<List<String>> rowData =
      List.generate(0, (index) => List.generate(0, (colIndex) => ''));
  bool display = true;

  @override
  void initState() {
    super.initState();
    fetchlesson();
  }

  Future<void> fetchlesson() async {
    if (widget.grade == 'Grade 1') {
      docID = 'klpfg14MaQIRm5yfqk4u';
    } else if (widget.grade == 'Grade 2') {
      docID = 'VSqeQfpysqAkYYHhSWGA';
    } else if (widget.grade == 'Grade 3') {
      docID = '1sX5TLd6MXl8kQD42q43';
    } else if (widget.grade == 'Grade 4') {
      docID = '5hlL0bScnBpTJaPFDcWt';
    } else if (widget.grade == 'Grade 5') {
      docID = 'EmjyO4Qf9dBU8zYmpZct';
    } else if (widget.grade == 'Grade 6') {
      docID = 'I7v0oFqQeVnrBR3hF9qm';
    } else {
      print('check your grade level');
    }
    if (docID != '') {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('lessons')
            .doc(docID)
            .get();

        if (!snapshot.exists) {
          print('No documents found');
          return;
        }

        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          String pre = 'post-assessment' + widget.post_assessment;
          words = (data[pre] as List<dynamic>?)?.cast<String>() ?? [];
          setState(() {});
          print(words);
        }
      } catch (e) {
        print('Error fetching data: $e');
      }

      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('score')
            .doc(widget.userId + widget.grade)
            .get();

        if (!snapshot.exists) {
          print('No documents found');
          return;
        }

        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data?[widget.lesson + ' 0 lesson'] != null && data?[widget.lesson + ' 0 lesson'].length > 9) {
          print(data?[widget.lesson + ' 0 lesson']);
         setState(() {
            present = '_';
         });
        }
       
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: Future.delayed(Duration(seconds: 2)),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Center(
            child: Center(child: Image.asset('assets/L1.gif'))
          ),
        );
      }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Choose.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.15),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, right: screenWidth * 0.05),
                    child: Column(
                      children: [
                        Text(
                          "Progress History",
                          style: TextStyle(
                              fontSize: screenHeight * 0.025,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.lesson + " lesson Scores",
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  present != '' ?
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      // padding: const EdgeInsets.all(2),
                      children: [
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('score')
                              .doc(widget.userId + widget.grade)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox.shrink();
                              // return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData ||
                                snapshot.data == null ||
                                !snapshot.data!.exists) {
                              print(
                                  'No documents found for the user ID: ${widget.userId}');
                              return Text('No data available');
                            }

                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            

                            List<DChartBarDataCustom> chartDataList = [];
                            List<Color> barColors = [
                              Colors.red,
                              Colors.blue,
                              Colors.green,
                              Colors.yellow,
                              Colors.pink,
                              Colors.grey,
                              Colors.orange,
                              Colors.brown,
                              Colors.indigo,
                              Colors.teal,
                              Colors.purple,
                              Colors.amber,
                              Colors.cyan,
                              Colors.deepOrange,
                              Colors.deepPurple,
                              Colors.lightBlue,
                              Colors.lightGreen,
                              Colors.lime,
                              Colors.orangeAccent,
                              Colors.purpleAccent,
                              Colors.redAccent,
                              Colors.tealAccent,
                              Colors.blueAccent,
                              Colors.greenAccent,
                              Colors.yellowAccent,
                              Colors.pinkAccent,
                              const Color.fromARGB(255, 117, 117, 117),
                              const Color.fromARGB(255, 141, 110, 99),
                              const Color.fromARGB(255, 57, 73, 171),
                              const Color.fromARGB(255, 38, 166, 154),
                              const Color.fromARGB(255, 142, 36, 170),
                              const Color.fromARGB(255, 255, 179, 0),
                              const Color.fromARGB(255, 0, 172, 193),
                              const Color.fromARGB(255, 248, 80, 29),
                              const Color.fromARGB(255, 94, 53, 177),
                              const Color.fromARGB(255, 6, 51, 74),
                              const Color.fromARGB(255, 31, 35, 26),
                              const Color.fromARGB(255, 128, 135, 42),
                              const Color.fromARGB(255, 114, 88, 55),
                              const Color.fromARGB(255, 224, 64, 251),
                              const Color.fromARGB(255, 255, 82, 82),
                              const Color.fromARGB(255, 182, 228, 217),
                              const Color.fromARGB(255, 43, 46, 50),
                              const Color.fromARGB(255, 51, 68, 60),
                              const Color.fromARGB(255, 109, 109, 64),
                            ];
                            if (data[widget.lesson + ' lesson'] != null &&
                                data[widget.lesson + ' lesson'].length > 9) {
                              List<dynamic>? scores =
                                  data[widget.lesson + ' lesson']
                                      as List<dynamic>?;
                              int totalScore = 0;
                              int numberOfScores = 0;
                              for (dynamic score in scores!) {
                                if (score is String) {
                                  int? parsedScore = int.tryParse(score);
                                  if (parsedScore != null) {
                                    totalScore += parsedScore;
                                    numberOfScores++;
                                  } else {
                                    print(
                                        'Warning: Failed to parse score $score as an integer.');
                                  }
                                }
                              }
                              if (numberOfScores > 0) {
                                int avg = totalScore ~/ numberOfScores;
                                Color barColor =
                                    barColors[i % barColors.length];
                                chartDataList.add(DChartBarDataCustom(
                                  value: avg.toDouble(),
                                  label: 'Take ${i}',
                                  color: Color.fromARGB(255, 35, 82, 105),
                                  showValue: true,
                                  valueStyle: TextStyle(color: Colors.white),
                                ));
                              }
                            }
                            for (i = 0; true; i++) {
                              String len = widget.lesson + ' ' + i.toString();
                              if (data[len + ' lesson'] != null) {
                                int length = data[len + ' lesson'].length;
                                if (length > 9) {
                                  List<dynamic>? scores =
                                      data[len + ' lesson'] as List<dynamic>?;
                                  int totalScore = 0;
                                  int numberOfScores = 0;
                                  for (dynamic score in scores!) {
                                    if (score is String) {
                                      int? parsedScore = int.tryParse(score);
                                      if (parsedScore != null) {
                                        totalScore += parsedScore;
                                        numberOfScores++;
                                      } else {
                                        print(
                                            'Warning: Failed to parse score $score as an integer.');
                                      }
                                    }
                                  }
                                  if (numberOfScores > 0) {
                                    int avg = totalScore ~/ numberOfScores;
                                    Color barColor =
                                        barColors[i % barColors.length];
                                    chartDataList.add(DChartBarDataCustom(
                                      value: avg.toDouble(),
                                      label: 'Take ${i + 2}',
                                      color: barColor,
                                      showValue: true,
                                      valueStyle:
                                          TextStyle(color: Colors.white),
                                    ));
                                  }
                                }
                              } else {
                                break;
                              }
                            }
                            if (present == '') {
                              return SizedBox.shrink();
                            } else {
                              return Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: DChartBarCustom(
                                      // verticalDirection: true,
                                      showDomainLine: true,
                                      showMeasureLine: true,
                                      showDomainLabel: true,
                                      showMeasureLabel: true,
                                      spaceMeasureLinetoChart: 2,
                                      radiusBar: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      max: 100,
                                      listData: chartDataList,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ) : SizedBox.shrink(),
                  present != ''
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox.shrink(),
                  present != ''
                      ? SingleChildScrollView(
                          child: Container(
                          width: double.infinity,
                          height: screenHeight * .40,
                          child: CustomScrollView(
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverToBoxAdapter(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('score')
                                        .doc(widget.userId + widget.grade)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        // return CircularProgressIndicator();
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data == null ||
                                          !snapshot.data!.exists) {
                                        print('No documents found for the user ID: ${widget.userId}');
                                        return SizedBox.shrink();
                                      }
                                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                                      return DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                                          return Colors.blue;
                                        }),
                                        columns: List<DataColumn>.generate(
                                          i + 2,
                                          (int columnIndex) {
                                            if (columnIndex == 0) {
                                              return DataColumn(label: Text('Words'));
                                            } else {
                                              return DataColumn(label: Text('Take ${columnIndex}'));
                                            }
                                          },
                                        ),
                                        rows: List<DataRow>.generate(
                                          10,
                                          (int rowIndex) {
                                            List<dynamic>? score;
                                            List<dynamic>? scores;
                                            print(rowIndex);

                                            return DataRow(
                                              cells: [
                                                for (int columnIndex = 0; columnIndex < i + 2; columnIndex++)
                                                  DataCell(
                                                    (() {
                                                      if (columnIndex == 1) {
                                                        score = data[widget.lesson + ' lesson'] as List<dynamic>?;
                                                      }
                                                      if (columnIndex >= 2) {
                                                        scores = data[widget.lesson + ' ' + (columnIndex - 2).toString() + ' lesson'] as List<dynamic>?;
                                                      }

                                                      return columnIndex == 0
                                                          ? Text(words[rowIndex])
                                                          : columnIndex == 1
                                                          ? score != null && score!.length > rowIndex
                                                          ? Text(
                                                        score![rowIndex].toString(),
                                                        style: TextStyle(
                                                          color: double.parse(score![rowIndex].toString()) <= 70 ? Colors.red : Colors.blue,
                                                        ),
                                                      )
                                                          : SizedBox.shrink()
                                                          : columnIndex >= 2
                                                          ? scores != null && scores!.length > rowIndex
                                                          ? Text(
                                                        scores![rowIndex].toString(),
                                                        style: TextStyle(
                                                          color: double.parse(scores![rowIndex].toString()) <= 70 ? Colors.red : Colors.blue,
                                                        ),
                                                      )
                                                          : SizedBox.shrink()
                                                          : SizedBox.shrink();
                                                    })(),
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        )
                      : SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * .65,
                      child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverToBoxAdapter(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('score')
                                    .doc(widget.userId + widget.grade)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return SizedBox.shrink();
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data == null ||
                                      !snapshot.data!.exists) {
                                    print('No documents found for the user ID: ${widget.userId}');
                                    return SizedBox.shrink();
                                  }

                                  Map<String, dynamic> data =
                                      snapshot.data!.data() as Map<String, dynamic>;

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: DataTable(
                                      headingRowColor: MaterialStateColor.resolveWith(
                                        (Set<MaterialState> states) {
                                          return Colors.blue;
                                        },
                                      ),
                                      columns: List<DataColumn>.generate(
                                        2,
                                        (int columnIndex) {
                                          if (columnIndex == 0) {
                                            return DataColumn(label: Text('Words'));
                                          } else {
                                            return DataColumn(label: Text('Take ${columnIndex}'));
                                          }
                                        },
                                      ),
                                      rows: List<DataRow>.generate(
                                        10,
                                        (int rowIndex) {
                                          List<dynamic>? score;

                                          return DataRow(
                                            cells: [
                                              for (int columnIndex = 0;
                                                  columnIndex < 2;
                                                  columnIndex++)
                                                DataCell(
                                                  (() {
                                                    if (columnIndex == 1 &&
                                                        data.containsKey(
                                                            '${widget.lesson} lesson')) {
                                                      score = data['${widget.lesson} lesson']
                                                          as List<dynamic>?;

                                                      if (score != null &&
                                                          score!.length > rowIndex &&
                                                          score![rowIndex] != null) {
                                                            double scoreValue = double.parse(score![rowIndex].toString());
                                                            return Text(
                                                              scoreValue.toString(),
                                                              style: TextStyle(
                                                                color: scoreValue <= 70
                                                                    ? Colors.red
                                                                    : Colors.blue,
                                                              ),
                                                            );
                                                      }
                                                    }
                                                    return columnIndex == 0
                                                        ? Text(words[rowIndex])
                                                        : SizedBox.shrink();
                                                  })(),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    });
  }
}
