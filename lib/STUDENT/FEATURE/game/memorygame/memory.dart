import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/word.dart';
import 'pages/error_page.dart';
import 'pages/game_page.dart';

List<Word> sourceWords = [];

Future<void> populateSourceWords() async {
  final ref = FirebaseStorage.instance.ref();
  final all = await ref.listAll();

  for (var item in all.items) {
    sourceWords.add(Word(
        text: item.name.substring(0, item.name.indexOf('.')),
        url: await item.getDownloadURL(),
        displayText: false));
  }
}
