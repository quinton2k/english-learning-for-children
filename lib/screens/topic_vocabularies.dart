import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_english/model/Vocabulary.dart';
import 'package:learning_english/noglow_behaviour.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   listVocab = fetchVocabList();
  // }
  Widget vocabularyCard(String word, String meaning, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VocabularyDetail(topic: widget.title, word: word)));
      },
      child: Card(
        color: Colors.grey[200],
        child: ListTile(
          title: Text(word),
          subtitle: Text(meaning),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C7352),
        title: Text(
          "Lesson: ${widget.title}",
          style: const TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
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
                  return vocabularyCard(
                      snapshot.data[i].word, snapshot.data![i].meaning, context);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return Center(child: Text('Loading'));
          },
        ),
      ),
    );
  }
}
