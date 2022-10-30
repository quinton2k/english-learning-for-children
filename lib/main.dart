// @dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_english/games/word_find_puzzle.dart';
import 'package:learning_english/screens/landing_page.dart';
import 'package:learning_english/screens/login.dart';
import 'package:learning_english/screens/signup_success.dart';
import 'package:learning_english/screens/signup.dart';
import 'package:learning_english/screens/topic_page.dart';
import 'package:learning_english/screens/topic_vocabularies.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WordFindPuzzle(),
      ),
    ),
  );
}
