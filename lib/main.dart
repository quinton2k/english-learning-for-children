import 'package:flutter/material.dart';
import 'package:learning_english/login.dart';

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
