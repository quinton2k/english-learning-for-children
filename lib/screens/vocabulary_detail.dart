import 'package:flutter/material.dart';
import 'package:learning_english/my_speaker_icon.dart';

class VocabularyDetail extends StatefulWidget {
  const VocabularyDetail({Key? key}) : super(key: key);

  @override
  State<VocabularyDetail> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetail> {
  String bePronunciation = '/ɪkˈstræk.tə ˌhʊd/';
  String aePronunciation = '/ɪkˈstræk.tɚ ˌhʊd/';
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
                "https://www.excellentesl4u.com/images/arm.jpg",
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff4C7352),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          MySpeakerIcon.volume,
                        ),
                        label: const Text('UK'),
                      ),
                    ),
                    Text('  $aePronunciation'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff4C7352),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          MySpeakerIcon.volume,
                        ),
                        label: const Text('US'),
                      ),
                    ),
                    Text('  $bePronunciation'),
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
                TextButton(onPressed: null, child: Text('Ban bi')),
                TextButton(onPressed: null, child: Text('Nhay du')),
              ],
            ),
          ])),
    );
  }
}
