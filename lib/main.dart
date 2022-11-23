// @dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_english/screens/landing_page.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'Gilroy'),
      home:  Scaffold(
        body: TopicListWidget(),
      ),
    ),
  );
}
