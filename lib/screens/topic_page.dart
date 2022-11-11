import 'package:flutter/material.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({Key? key}) : super(key: key);

  GestureDetector modeButton(
      String title, String subtitle, IconData icon, Color color, double width) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
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
        title: const Text(
          'Color',
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
                        width),
                    modeButton('Detection', 'Detection objects',
                        FontAwesomeIcons.image, Color(0xffdf1D5A), width),
                    modeButton('True False', 'Decide whether it true or false',
                        FontAwesomeIcons.question, Color(0xff45d280), width),
                    modeButton(
                        'Drag and Drop game',
                        'Drag the image into the correct word',
                        FontAwesomeIcons.hand,
                        Color(0xffff8306),
                        width),
                    modeButton('Word find', 'Complete words',
                        FontAwesomeIcons.puzzlePiece, Color(0xffdf1D5A), width),
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
