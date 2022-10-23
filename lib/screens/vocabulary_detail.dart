import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:learning_english/my_speaker_icon.dart';

class VocabularyDetail extends StatefulWidget {
  const VocabularyDetail({Key? key}) : super(key: key);

  @override
  State<VocabularyDetail> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetail> {
  bool notTouched = true;
  final audioPlayer = AudioPlayer();
  String bePronunciation = '/ˈbɑː.skɪt.bɔːl/';
  String aePronunciation = '/ˈbæs.kət.bɑːl/';
  // String aePronunciation = '/ˈbɑː.skɪt.bɔːl/';

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
          MySpeakerIcon.volume,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basketball".toLowerCase()),
        backgroundColor: const Color(0xff4C7352),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: ListView(children: [
            SizedBox(
              height: 250,
              child: Image.network(
                "https://www.anglomaniacy.pl/img/xv-basketball.png.pagespeed.ic.RGoAf1ChnQ.webp",
                // height: 300,
              ),
            ),
            const Divider(color: Colors.black12),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: Text(
                  'Bóng rổ',
                  style: TextStyle(
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
                      child: renderPronunciation(aePronunciation),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: renderIcon('US',
                          'https://dictionary.cambridge.org/vi/media/english/uk_pron/u/ukb/ukbas/ukbashf013.mp3'),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      child: renderPronunciation(bePronunciation),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: renderIcon('UK',
                          'https://dictionary.cambridge.org/vi/media/english/uk_pron/u/ukb/ukbas/ukbashf013.mp3'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                  child: Text('Từ đề xuất:'),
                ),
                TextButton(onPressed: null, child: Text('Football')),
                TextButton(onPressed: null, child: Text('Tennis')),
                TextButton(onPressed: null, child: Text('Hockey')),
              ],
            ),
          ])),
    );
  }
}
