import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List<String> student = [];
  Map<String, int> studentScores = {};
  
  @override
  void initState() {
    super.initState();
    students();
  }

  void students() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();
    if (snapshot.docs.isEmpty) {
      print('No documents found for students in user collection');
      return;
    }
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      student.add(doc.id);
    }
    StudentName();
    print(student);
    setState(() {});
  } catch (e) {
    print('Error fetching data: $e');
  }
}


  void StudentName() async {
    for (int i = 0; i < student.length; i++) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(student[i])
            .get();

        if (!snapshot.exists) {
          print('No documents found for students in user collection');
          return;
        }
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data['Firstname'] != null && data['Lastname'] != null) {
          var studentName = data['Firstname'] + ' ' + data['Lastname'];
          studentScores[studentName] = await StudentScore(i); 
        }
        setState(() {});
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<int> StudentScore(int i) async {
  int total = 0;
  total = await StudentScore1(i) +
          await StudentScore2(i) +
          await StudentScore3(i) +
          await StudentScore4(i) +
          await StudentScore5(i) +
          await StudentScore6(i);
  return total;
}


//Grade 1
  Future<int> StudentScore1(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 1')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 2
  Future<int> StudentScore2(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 2')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 3
  Future<int> StudentScore3(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 3')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 4
  Future<int> StudentScore4(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 4')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 5
  Future<int> StudentScore5(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 5')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

//Grade 6
  Future<int> StudentScore6(int i) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('score')
        .doc(student[i]+'Grade 6')
        .get();

    if (!snapshot.exists) {
      print('No score found');
      return 0;
    }
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    if (data != null) {
      int average, score1, score2, score3, score4, score5, score6, score7, score8, score9, score10, score11, score12, score13, score14, score15, score16, score17, score18, score19, score20;
    //lesson 1
      if(data['1-1 lesson'] != null){
        List<int> studentScores = (data['1-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score1 = (sum / 10).toInt();
      }else{
        score1 = 0;
      }
    //lesson 2
      if(data['1-2 lesson'] != null){
        List<int> studentScores = (data['1-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score2 = (sum / 10).toInt();
      }else{
        score2 = 0;
      }
    //lesson 3
      if(data['1-3 lesson'] != null){
        List<int> studentScores = (data['1-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score3 = (sum / 10).toInt();
      }else{
        score3 = 0;
      }
    //lesson 4
      if(data['1-4 lesson'] != null){
        List<int> studentScores = (data['1-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score4 = (sum / 10).toInt();
      }else{
        score4 = 0;
      }

      //lesson 5
      if(data['1-5 lesson'] != null){
        List<int> studentScores = (data['1-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score5 = (sum / 10).toInt();
      }else{
        score5 = 0;
      }
    //lesson 6
      if(data['2-1 lesson'] != null){
        List<int> studentScores = (data['2-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score6 = (sum / 10).toInt();
      }else{
        score6 = 0;
      }
    //lesson 7
      if(data['2-2 lesson'] != null){
        List<int> studentScores = (data['2-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score7 = (sum / 10).toInt();
      }else{
        score7 = 0;
      }
    //lesson 8
      if(data['2-3 lesson'] != null){
        List<int> studentScores = (data['2-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score8 = (sum / 10).toInt();
      }else{
        score8 = 0;
      }
    //lesson 9
      if(data['2-4 lesson'] != null){
        List<int> studentScores = (data['2-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score9 = (sum / 10).toInt();
      }else{
        score9 = 0;
      }
    //lesson 10
      if(data['2-5 lesson'] != null){
        List<int> studentScores = (data['2-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score10 = (sum / 10).toInt();
      }else{
        score10 = 0;
      }
      //lesson 11
      if(data['3-1 lesson'] != null){
        List<int> studentScores = (data['3-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score11 = (sum / 10).toInt();
      }else{
        score11 = 0;
      }
      //lesson 12
      if(data['3-2 lesson'] != null){
        List<int> studentScores = (data['3-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score12 = (sum / 10).toInt();
      }else{
        score12 = 0;
      }
      //lesson 13
      if(data['3-3 lesson'] != null){
        List<int> studentScores = (data['3-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score13 = (sum / 10).toInt();
      }else{
        score13 = 0;
      }
      //lesson 14
      if(data['3-4 lesson'] != null){
        List<int> studentScores = (data['3-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score14 = (sum / 10).toInt();
      }else{
        score14 = 0;
      }
      //lesson 15
      if(data['3-5 lesson'] != null){
        List<int> studentScores = (data['3-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score15 = (sum / 10).toInt();
      }else{
        score15 = 0;
      }
      //lesson 16
      if(data['4-1 lesson'] != null){
        List<int> studentScores = (data['4-1 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score16 = (sum / 10).toInt();
      }else{
        score16 = 0;
      }
      //lesson 17
      if(data['4-2 lesson'] != null){
        List<int> studentScores = (data['4-2 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score17 = (sum / 10).toInt();
      }else{
        score17 = 0;
      }
      //lesson 18
      if(data['4-3 lesson'] != null){
        List<int> studentScores = (data['4-3 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score18 = (sum / 10).toInt();
      }else{
        score18 = 0;
      }
      //lesson 19
      if(data['4-4 lesson'] != null){
        List<int> studentScores = (data['4-4 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score19 = (sum / 10).toInt();
      }else{
        score19 = 0;
      }
      //lesson 20
      if(data['4-5 lesson'] != null){
        List<int> studentScores = (data['4-5 lesson'] as List<dynamic>?)
          ?.map((dynamic score) => int.tryParse(score.toString()) ?? 0)
          ?.toList() ?? [];

      int sum = 0;
      for (int score in studentScores) {
        sum += score;
      }

        score20 = (sum / 10).toInt();
      }else{
        score20 = 0;
      }
      int total = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10+score11+score12+score13+score14+score15+score16+score17+score18+score19+score20;
      return average = (total / 20).toInt();
    }
    return 0;
  }

@override
Widget build(BuildContext context) {
  final sortedStudentScores = Map.fromEntries(studentScores.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value)));

  List<int> top3UniqueScores = [];
  int scoreCount = 0;

  for (var score in sortedStudentScores.values) {
    if (scoreCount >= 3) {
      break;
    }
    if (!top3UniqueScores.contains(score)) {
      top3UniqueScores.add(score);
      scoreCount++;
    }
  }

  Map<int, String> rankImages = {
    1: 'assets/images/1st.png',
    2: 'assets/images/2nd.png',
    3: 'assets/images/3rd.png',
  };
  return Scaffold(
    body: SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grass 1.png'),
            alignment: Alignment.bottomCenter,
            repeat: ImageRepeat.repeatX,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.green[800]),
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                'Leader Board',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Name', style: TextStyle(color: Colors.grey),),
                Text('Ranking', style: TextStyle(color: Colors.grey),)
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sortedStudentScores.length,
                itemBuilder: (BuildContext context, int index) {
                  final studentName = sortedStudentScores.keys.elementAt(index);
                  final studentScore = sortedStudentScores[studentName];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 20, right: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(studentName),
                        Row(
                          children: [
                            Text(studentScore.toString()),
                            if (top3UniqueScores.contains(studentScore))
                              Image.asset(
                                rankImages[top3UniqueScores.indexOf(studentScore!) + 1]!,
                                width: 30,
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}