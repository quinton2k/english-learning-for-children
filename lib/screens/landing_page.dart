import 'package:flutter/material.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/sidebar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  Widget topicSection(String topicName) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xff4C7352),
        border: Border.all(
          color: const Color(0xff4C7352),
        ),
      ),
      child: TextButton(
          onPressed: () {},
          child: Text(
            topicName,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  List<Widget> listViewUI() {
    var result = <Widget>[];
    List<String> topics = [
      "Color",
      "Family",
      "School",
      "Vehicle",
      "Toy",
      "Sport",
      "Food",
      "Home",
      "Animal"
    ];
    for (int i = 0; i < topics.length; i++) {
      result.add(topicSection(topics[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('mai cồ trần'),
        backgroundColor: const Color(0xff4C7352),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: ListView(children: listViewUI()),
      ),
    );
  }
}
