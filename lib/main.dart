import 'package:flutter/material.dart';
import 'package:learning_english/screens/login.dart';
import 'package:learning_english/screens/signup_success.dart';
import 'package:learning_english/screens/signup.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SignUpSuccess(),
      ),
    ),
  );
}
