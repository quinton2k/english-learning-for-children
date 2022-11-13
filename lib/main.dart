// @dart=2.9
import 'package:flutter/material.dart';
import 'package:learning_english/games/drag_n_drop.dart';
import 'package:learning_english/screens/edit_profile_page.dart';
import 'package:learning_english/screens/landing_page.dart';


void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TopicListWidget(),
      ),
    ),
  );
}
