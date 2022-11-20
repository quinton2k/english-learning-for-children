import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_english/model/vocabulary.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:learning_english/screens/topic_page.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';

class TopicListWidget extends StatefulWidget {
  const TopicListWidget({Key? key}) : super(key: key);

  @override
  State<TopicListWidget> createState() => _TopicListWidgetState();
}

class _TopicListWidgetState extends State<TopicListWidget> {
  late Future<TopicList> listTopic;

  @override
  void initState() {
    super.initState();
    listTopic = fetchTopicList();
  }

  Future<TopicList> fetchTopicList() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/v1/topic/getTopics'));
    if (response.statusCode == 200) {
      return TopicList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load topic list');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Choose topic'),
        backgroundColor: const Color(0xff272837),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: FutureBuilder<TopicList>(
          future: listTopic,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.quantity,
                itemBuilder: (context, i) {
                  var topicIcon = {
                    'Animal': FontAwesomeIcons.paw,
                    'Color': FontAwesomeIcons.palette,
                    'Food': FontAwesomeIcons.bowlFood,
                    'Home': FontAwesomeIcons.house,
                    'People': FontAwesomeIcons.child,
                    'School': FontAwesomeIcons.schoolFlag,
                    'Sport': FontAwesomeIcons.medal,
                    'Toy': FontAwesomeIcons.robot,
                    'Vehicle': FontAwesomeIcons.motorcycle,
                    'Verb': FontAwesomeIcons.personRunning
                  };
                  return topicButton(
                      snapshot.data!.topics[i],
                      topicIcon[snapshot.data!.topics[i]] ?? Icons.dangerous,
                      width);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            // return const CircularProgressIndicator();
            return const Text("Code dang chay toi dong nay");
          },
        ),
      ),
    );
  }

  GestureDetector topicButton(String title, IconData icon, double width) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TopicPage(topic: title),
        ));
      }),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          height: 60,
          // width: width,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FaIcon(
                icon,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  List<Widget> listViewUI(double width, List<dynamic> topics) {
    var result = <Widget>[];
    var topicIcon = {
      'Animal': FontAwesomeIcons.paw,
      'Color': FontAwesomeIcons.palette,
      'Food': FontAwesomeIcons.bowlFood,
      'Home': FontAwesomeIcons.house,
      'People': FontAwesomeIcons.child,
      'School': FontAwesomeIcons.schoolFlag,
      'Sport': FontAwesomeIcons.medal,
      'Toy': FontAwesomeIcons.robot,
      'Vehicle': FontAwesomeIcons.motorcycle,
      'Verb': FontAwesomeIcons.personRunning
    };

    result.add(const SizedBox(height: 10));
    for (int i = 0; i < topics.length; i++) {
      String topicName = topics[i].toString();
      result.add(
          topicButton(topicName, topicIcon[topicName] ?? Icons.abc, width));
      result.add(const SizedBox(height: 10));
    }

    return result;
  }
}

class TopicList {
  final int quantity;
  final List<dynamic> topics;

  const TopicList({
    required this.quantity,
    required this.topics,
  });

  factory TopicList.fromJson(Map<String, dynamic> json) {
    return TopicList(
      quantity: json['topicQuantity'],
      topics: json['allTopics'],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  fetchAllVocab() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/topic/vocabs'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<Vocabulary> listVocab = [];
      for (var voca in jsonData) {
        Vocabulary temp = Vocabulary.fromJson(voca);
        listVocab.add(temp);
      }

      return listVocab;
    } else {
      throw Exception('Failed to load all vocab for searching');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // throw UnimplementedError();

    return FutureBuilder(
      future: fetchAllVocab(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Vocabulary> matchQuery = [];
          for (var word in snapshot.data) {
            if (word.word
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
              matchQuery.add(word);
            }
          }
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                title: Text(result.word.replaceAll('_', ' ')),
                onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VocabularyDetail(word: result.word, topic: result.topicName)));
                }
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Text('Co loi ');
        }
        return const Center(
          child: Text('Loading zzz'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
    return FutureBuilder(
        future: fetchAllVocab(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Co loi ');
          }
          if (snapshot.hasData) {
            List<Vocabulary> matchQuery = [];
            for (var word in snapshot.data) {
              if (word.word
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase())) {
                matchQuery.add(word);
              }
            }
            return ListView.builder(
              itemCount: matchQuery.length,
              itemBuilder: (context, index) {
                var result = matchQuery[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VocabularyDetail(word: result.word, topic: result.topicName)));
                  },
                  title: Text(result.word.replaceAll('_', ' ')),
                );
              },
            );
          }
          return const Center(
            child: Text('Loading zzz'),
          );
        });
  }
}
