import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_english/noglow_behaviour.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({Key? key}) : super(key: key);

  Widget topicSection(String contentName) {
    return Container(
      height: 60,
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
            contentName,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          )),
    );
  }

  List<Widget> listViewUI() {
    var result = <Widget>[];
    List<String> contents = [
      "Vocabulary",
      "Game 1",
      "Game 2",
      "Game 3",
      "Game 4"
    ];
    for (int i = 0; i < contents.length; i++) {
      result.add(topicSection(contents[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C7352),
        title: const Text(
          'Color',
          style: TextStyle(fontFamily: 'SunnySpells', fontSize: 30),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: ListView(
          children: [
            ListBody(
              children: listViewUI(),
            )
          ],
        ),
      ),
    );
  }
}
