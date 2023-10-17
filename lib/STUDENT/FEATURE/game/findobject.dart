import 'package:flutter/material.dart';

class FindObjects extends StatefulWidget {
  final String userId;
  final String grade;
  const FindObjects({super.key, required this.userId, required this.grade});

  @override
  State<FindObjects> createState() => _FindObjectsState();
}

class _FindObjectsState extends State<FindObjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        
      )
    );
  }
}