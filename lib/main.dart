import 'package:flutter/material.dart';
import 'package:learning_english/screens/login.dart';
import 'package:learning_english/screens/signup.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Login(),
      ),
    ),
  );
}
