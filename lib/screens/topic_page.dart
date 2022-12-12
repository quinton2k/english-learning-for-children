import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_english/games/drag_n_drop.dart';
import 'package:learning_english/games/true_false_questions.dart';
import 'package:learning_english/games/word_find_puzzle.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_english/screens/common_widget.dart';
import 'package:learning_english/screens/no_result_found.dart';
import 'package:learning_english/screens/select_photo_options.dart';
import 'package:learning_english/screens/topic_vocabularies.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';

class TopicPage extends StatefulWidget {
  final String topic;
  const TopicPage({Key? key, required this.topic}) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  bool isLoading = false;
  // pick Image function
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      XFile? pickI = (await ImagePicker().pickImage(source: source));
      if (pickI == null) return;

      File tempImage = File(pickI.path);
      setState(() {
        image = tempImage;
        Navigator.of(context).pop();
        // print(image!.path);
        uploadImage(image!.path);
        isLoading = true;
      });

      print('Dia chi cua image: {$image!.path}');
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      Navigator.of(context).pop();
    }
  }

  Future<void> uploadImage(filepath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8000/detection/animal/'));
    request.files.add(await http.MultipartFile.fromPath('myfile', filepath));
    print(request.files);
    var res = await request.send();
    var respStr = await res.stream.bytesToString();
    respStr = respStr.replaceAll('{', '');
    respStr = respStr.replaceAll('}', '');
    respStr = respStr.replaceAll('"', '');
    respStr = respStr.replaceAll('vocab:', '');
    respStr = respStr.replaceAll('topic:', '');
    respStr = respStr.replaceAll('percent:', '');

    String vocab = respStr.substring(0, respStr.indexOf(','));
    String topic =
        respStr.substring(respStr.indexOf(',') + 1, respStr.lastIndexOf(','));
    setState(() {
      isLoading = false;
    });
    if (vocab.toLowerCase() == 'unknown') {
      // showErrorDialog();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NoResultFoundScreen()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VocabularyDetail(topic: topic, word: vocab)));
    }

    print(respStr);
    // return respStr;
  }

  // select function
  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: pickImage,
              ),
            );
          }),
    );
  }

  GestureDetector modeButton(String title, String subtitle, IconData icon,
      Color buttonColor, Color color, double width, BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (title == 'Vocabulary') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListVocabulary(title: widget.topic),
          ));
        }

        if (title == 'Detection') {
          //Todo: Handle detection page
          // _showSelectPhotoOptions(context);
          _showSelectPhotoOptions(context);
        }

        if (title == 'True False') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrueFalseGame(topic: widget.topic),
          ));
        }
        if (title == 'Word find') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WordFindPuzzle(topic: widget.topic)));
        }
        if (title == 'Matching') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MatchingGame(topic: widget.topic),
          ));
        }
      }),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'Manrope',
                      color: color,
                      fontSize: 18.0,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5.0),
                  //   child: Text(
                  //     subtitle,
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       decoration: TextDecoration.none,
                  //       fontFamily: 'Manrope',
                  //       color: Colors.grey,
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FaIcon(
                icon,
                color: color,
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
    return isLoading
        ? const LoadingDetection()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff2b5b89),
              title: Text(
                widget.topic,
                style: const TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 184, 218, 250)),
              ),
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //   icon: const Icon(
              //     Icons.arrow_back,
              //     color: Color.fromARGB(255, 184, 218, 250),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const TopicListWidget(),
              //     ));
              //   },
              // ),
            ),
            body: ScrollConfiguration(
              behavior: NoGlowBehaviour(),
              child: Container(
                color: Colors.white,
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
                              Color.fromARGB(255, 233, 244, 229),
                              Color(0xff417c66),
                              width,
                              context),
                          if (widget.topic == 'Animal')
                            modeButton(
                                'Detection',
                                'Detection objects',
                                FontAwesomeIcons.image,
                                Color.fromARGB(255, 245, 225, 216),
                                Color(0xffac4c2c),
                                width,
                                context),
                          modeButton(
                              'True False',
                              'Decide whether it true or false',
                              FontAwesomeIcons.question,
                              Color.fromARGB(255, 245, 232, 240),
                              Color(0xffb46c6d),
                              width,
                              context),
                          modeButton(
                              'Matching',
                              'Drag the image into the correct word',
                              FontAwesomeIcons.hand,
                              Color.fromARGB(255, 222, 236, 249),
                              const Color(0xff2b5b89),
                              width,
                              context),
                          modeButton(
                              'Word find',
                              'Complete words',
                              FontAwesomeIcons.puzzlePiece,
                              Color.fromARGB(255, 247, 238, 219),
                              Color(0xffb2955d),
                              width,
                              context),
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

class PredictedWord {
  final String name;
  final String topic;

  PredictedWord({required this.name, required this.topic});

  factory PredictedWord.fromJson(Map<String, dynamic> json) {
    return PredictedWord(
      name: json['name'],
      topic: json['topic'],
    );
  }
}
