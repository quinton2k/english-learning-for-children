import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VocabularyDetail extends StatefulWidget {
  const VocabularyDetail({Key? key}) : super(key: key);

  @override
  State<VocabularyDetail> createState() => _VocabularyDetailState();
}

class _VocabularyDetailState extends State<VocabularyDetail> {
  AudioPlayer audioPlayer = AudioPlayer();
  String url =
      'https://drive.google.com/drive/folders/1060QRut9in9CqMIlJGNbWm32v_xoCwb2';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  playMusic() async {
    await audioPlayer.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ambulance".toLowerCase()),
        backgroundColor: Color(0xff4C7352),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: ListView(children: [
            Image.network(
              "https://www.anglomaniacy.pl/img/xv-van.png.pagespeed.ic.KgC879sDel.webp",
              width: 50.0,
            ),
            const Center(
              child: Text(
                'Xe cứu thương',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                playMusic();
              },
              child: const Text(
                'UK',
                style: TextStyle(fontSize: 18, color: Color(0xff4C7352)),
              ),
            ),
          ])),
    );
  }
}

// class VocabularyDetail extends StatelessWidget {
//   VocabularyDetail({Key? key}) : super(key: key);

//   final audioPlayer = AudioPlayer();
//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Ambulance".toLowerCase()),
    //     backgroundColor: Color(0xff4C7352),
    //   ),
    //   body: Padding(
    //       padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
    //       child: ListView(children: [
    //         Image.network(
    //           "https://www.anglomaniacy.pl/img/xv-van.png.pagespeed.ic.KgC879sDel.webp",
    //           width: 50.0,
    //         ),
    //         const Center(
    //           child: Text(
    //             'Xe cứu thương',
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 25,
    //             ),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             audioPlayer.play(AssetSource('audio/Vehicle_Ambulance.mp3'));
    //             print('Di toi trang signup');
    //           },
    //           child: const Text(
    //             'UK',
    //             style: TextStyle(fontSize: 18, color: Color(0xff4C7352)),
    //           ),
    //         ),
    //       ])),
    // );
//   }
// }
