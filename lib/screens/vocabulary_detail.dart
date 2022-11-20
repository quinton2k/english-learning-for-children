import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:learning_english/model/detail_vocabulary.dart';
import 'package:http/http.dart' as http;
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/topic_vocabularies.dart';

class VocabularyDetail extends StatefulWidget {
  final String word;
  final String topic;
  const VocabularyDetail({Key? key, required this.word, required this.topic})
      : super(key: key);

  @override
  State<VocabularyDetail> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetail> {
  late Future<DetailVocab> vocabulary;

  bool notTouched = true;
  final audioPlayer = AudioPlayer();

  Future<DetailVocab> fetchVocabDetail() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:3000/api/v1/topic/getTopicDetail/${widget.topic}/${widget.word}'));
    if (response.statusCode == 200) {
      return DetailVocab.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail vocab');
    }
  }

  @override
  void initState() {
    super.initState();
    vocabulary = fetchVocabDetail();
  }

  Widget renderIcon(String type, String url) {
    return Container(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff4C7352),
        ),
        onPressed: () async {
          if (notTouched) {
            await audioPlayer.setUrl(url);
            audioPlayer.play();
            notTouched = false;
          }
          Future.delayed(const Duration(milliseconds: 2000), () {
            notTouched = true;
          });
        },
        icon: const Icon(
          FontAwesomeIcons.volumeHigh,
          size: 10,
        ),
        label: Text(type),
      ),
    );
  }

  Widget renderPronunciation(String pronunciation) {
    return Container(
      child: Text('   $pronunciation'),
    );
  }

  Widget appBody(
      String vocab,
      String meaing,
      String bePronun,
      String aePronun,
      String beAudio,
      String aeAudio,
      String image,
      List<String> suggested,
      BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: SizedBox(
          height: 500,
          child: ListView(
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 250,
                  child: Image.network(
                    image,
                    // height: 300,
                  ),
                ),
                const Divider(color: Colors.black12),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: Text(
                      meaing,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          child: renderPronunciation(aePronun),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: renderIcon('US', aeAudio),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          child: renderPronunciation(bePronun),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: renderIcon('UK', beAudio),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                      child: Text('Từ đề xuất:'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VocabularyDetail(
                                word: suggested[0], topic: widget.topic),
                          ));
                        },
                        child: Text(suggested[0])),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VocabularyDetail(
                              word: suggested[1], topic: widget.topic),
                        ));
                      },
                      child: Text(suggested[1]),
                    ),
                  ],
                ),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: widget.word.replaceAll('_', ' '),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.word.replaceAll('_', ' ').toLowerCase()),
          backgroundColor: const Color(0xff4C7352),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => ListVocabulary(title: widget.topic),
              // ));
            },
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.search),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: ScrollConfiguration(
            behavior: NoGlowBehaviour(),
            child: FutureBuilder<DetailVocab>(
              future: vocabulary,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: ((context, index) {
                      return appBody(
                          snapshot.data!.vocab,
                          snapshot.data!.hasMeaning,
                          snapshot.data!.hasBEpronunciation,
                          snapshot.data!.hasBEpronunciation,
                          snapshot.data!.hasBEAudio,
                          snapshot.data!.hasAEAudio,
                          snapshot.data!.hasImage,
                          snapshot.data!.suggestArr,
                          context);
                    }),
                  );
                }
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: Text('Loading'));
              },
            )),
      ),
    );
  }
}
