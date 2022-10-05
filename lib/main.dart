import 'package:flutter/material.dart';
import 'package:learning_english/login.dart';
import 'package:learning_english/signup.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SignUp(),
      ),
    ),
  );
}
