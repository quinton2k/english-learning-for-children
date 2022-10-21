import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class VocabularyDetail extends StatefulWidget {
  const VocabularyDetail({Key? key}) : super(key: key);

  @override
  State<VocabularyDetail> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetail> {
  String bePronunciation = '/ˈæm.bjə.ləns/';
  String aePronunciation = '/ˈæm.bjə.ləns/';
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
              child: Text(
                'Bóng rổ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff4C7352),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.phonelink_ring,
                      ),
                      label: const Text('UK'),
                    ),
                    Text(' $aePronunciation'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff4C7352),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.phonelink_ring,
                      ),
                      label: const Text('US'),
                    ),
                    Text(' $bePronunciation'),
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
