import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_english/model/Vocabulary.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/common_widget.dart';
import 'package:learning_english/screens/topic_page.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';
import 'package:http/http.dart' as http;

class ListVocabulary extends StatefulWidget {
  final String title;
  const ListVocabulary({Key? key, required this.title}) : super(key: key);

  @override
  State<ListVocabulary> createState() => _ListVocabularyState();
}

class _ListVocabularyState extends State<ListVocabulary> {
  fetchVocabList() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:3000/api/v1/topic/getTopicList/${widget.title}'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<Vocabulary> listVocab = [];
      for (var voca in jsonData) {
        Vocabulary temp = Vocabulary.fromJson(voca);
        listVocab.add(temp);
      }

      return listVocab;
    } else {
      throw Exception('Failed to load topic list');
    }
  }

  Widget vocabularyCard(
      String word, String meaning, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                VocabularyDetail(topic: widget.title, word: word)));
      },
      child: Card(
        color: color,
        child: ListTile(
          title: Text(word.replaceAll('_', ' ')),
          subtitle: Text(meaning),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2b5b89),
        title: Text("Lesson: ${widget.title}",
            style: const TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 184, 218, 250))),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: FutureBuilder(
          future: fetchVocabList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  Color color = Colors.grey[100]!;
                  if (i % 2 == 0) {
                    color = Colors.white;
                  }
                  return vocabularyCard(snapshot.data[i].word,
                      snapshot.data![i].meaning, color, context);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const LoadingPage();
          },
        ),
      ),
    );
  }
}
