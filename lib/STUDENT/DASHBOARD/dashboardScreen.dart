import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;
  const DashboardScreen({super.key, required this.userId});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
    int highestScore = 0;
    int lowestScore = 0;
    String unitHighestScore = '';
    String unitLowestScore = '';
    String currentUnit = '';
    String unit = '';

@override
void initState() {
  super.initState();
  assessment();
}

Future<void> assessment() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('dashboard')
        .doc(widget.userId)
        .get();

    if (!snapshot.exists) {
      print('No documents found for the user ID: ${widget.userId}');
      return;
    }

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      setState(() {
        highestScore = data['Highest_score'] ?? 0;
        lowestScore = data['Lowest_score'] ?? 0;
        unitHighestScore = data['Unit_Highest_score'] ?? '';
        unitLowestScore = data['Unit_Lowest_score'] ?? '';
        unit = data['Current_unit'] ?? 'Unit 1';
      });
    } else {
      print('Data is null for the user ID: ${widget.userId}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

 @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/image 2.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * .05, right: screenWidth * .05),
                width: double.infinity,
                height: screenHeight * .4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0), 
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * .02, right: screenWidth * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * .03, color: Color(0xFF07883A),),),
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.close)),
                          ],
                        ),
                      ),
                      Divider(
                          height: 2, 
                          color: Color.fromARGB(255, 93, 92, 92), 
                        ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * .02, right: screenWidth * .02, top: screenHeight * .03),
                        width: double.infinity,
                        height: screenHeight * .08,
                        decoration: BoxDecoration(
                          color: Color(0xFF009DF5),
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Current Unit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text(unit, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * .02, right: screenWidth * .02, top: screenHeight * .01),
                        width: double.infinity,
                        height: screenHeight * .08,
                        decoration: BoxDecoration(
                          color: Color(0xFF07883A),
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/upp.png'),
                            Text('Highest Score', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(unitHighestScore, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                Text('Score: '+ highestScore.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                              ],
                            )
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * .02, right: screenWidth * .02, top: screenHeight * .01),
                        width: double.infinity,
                        height: screenHeight * .08,
                        decoration: BoxDecoration(
                          color: Color(0xFFEF1B1B),
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/down.png'),
                            Text('Lowest Score', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(unitLowestScore, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                Text('Score: '+ lowestScore.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                              ],
                            )
                          ],
                        )
                      ),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
