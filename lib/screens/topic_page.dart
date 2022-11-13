import 'package:flutter/material.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_english/screens/topic_vocabularies.dart';

class TopicPage extends StatelessWidget {
  final String title;
  const TopicPage({Key? key, required this.title}) : super(key: key);

  GestureDetector modeButton(String title, String subtitle, IconData icon,
      Color color, double width, BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (title == 'Vocabulary') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListVocabulary(title: this.title),
          ));
        }

        if (title == 'Detection') {
          //Todo: Handle detection page
        }

        if (title == 'True False') {

        }
        if (title == 'Word find') {

        }
        if (title == 'Drag and Drop game') {
          
        }
      }),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FaIcon(
                icon,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C7352),
        title: Text(
          title,
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Container(
          color: const Color(0xff272837),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Wrap(
                  runSpacing: 16,
                  children: [
                    modeButton(
                        'Vocabulary',
                        'Learn Words',
                        FontAwesomeIcons.chalkboardUser,
                        Color(0xFF2F80ED),
                        width,
                        context),
                    if (title == 'Vehicle' || title == 'Animal')
                      modeButton('Detection', 'Detection objects',
                          FontAwesomeIcons.image, Color(0xffdf1D5A), width, context),
                    modeButton('True False', 'Decide whether it true or false',
                        FontAwesomeIcons.question, Color(0xff45d280), width, context),
                    modeButton(
                        'Drag and Drop game',
                        'Drag the image into the correct word',
                        FontAwesomeIcons.hand,
                        Color(0xffff8306),
                        width, context),
                    modeButton('Word find', 'Complete words',
                        FontAwesomeIcons.puzzlePiece, Color(0xffdf1D5A), width, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
