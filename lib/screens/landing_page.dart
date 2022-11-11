import 'package:flutter/material.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  GestureDetector topicButton(String title, IconData icon, double width) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        height: 80,
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
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> listViewUI(double width) {
    var result = <Widget>[];
    var topics = {
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
    topics.forEach((key, value) {
      result.add(topicButton(key, value, width));
      result.add(const SizedBox(height: 10));
    });

    return result;
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
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Container(
            // color: Colors.red[300],
            child: ListView(children: listViewUI(width))),
      ),
    );
  }
}
