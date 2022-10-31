// @dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_english/games/true_false_questions.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TrueFalseGame(),
      ),
    ),
  );
}
