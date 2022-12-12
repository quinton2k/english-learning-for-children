import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_english/screens/topic_page.dart';

class MatchingGame extends StatefulWidget {
  final String topic;
  const MatchingGame({Key? key, required this.topic}) : super(key: key);

  @override
  State<MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  // MatchingItem itemList = MatchingItem();
  var player = AudioCache();
  late bool noQuestion = false;
  List<MatchingItem>? item1;
  List<MatchingItem>? item2;
  int? score;
  bool? gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    item1 = [
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Green',
          value: 'green',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/forest-green-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Purple',
          value: 'purple',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/purple-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Black',
          value: 'black',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/black-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Brown',
          value: 'brown',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/dark-brown-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Red',
          value: 'red',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/neon-red-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Orange',
          value: 'orange',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/orange-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Yellow',
          value: 'yellow',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/bright-yellow-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Pink',
          value: 'pink',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/pastel-pink-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Color',
          name: 'Blue',
          value: 'blue',
          imagePath:
              'https://htmlcolorcodes.com/assets/images/colors/blue-color-solid-background-1920x1080.png'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Cat',
          value: 'cat',
          imagePath:
              'https://img.freepik.com/free-vector/cute-cat-yoga-pose-cartoon-illustration_138676-2791.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Rabbit',
          value: 'rabbit',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-bunny-holding-carrot-cartoon-illustration_403370-193.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Hamster',
          value: 'hamster',
          imagePath:
              'https://img.freepik.com/free-vector/cute-hamster-holding-cheek-cartoon-illustration_138676-2773.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Elephant',
          value: 'elephant',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-elephant-sitting-icon-illustration-elephant-mascot-cartoon-character-animal-icon-concept-isolated_138676-911.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Hedgehog',
          value: 'hedgehog',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-hedgehog-cartoon-icon-illustration-animal-nature-icon-concept-isolated-flat-cartoon-style_138676-3087.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Pig',
          value: 'pig',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-pig-sleeping-vector-illustration-lazy-lying-pig-cartoon_562381-88.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Gecko',
          value: 'gecko',
          imagePath:
              'https://img.freepik.com/free-vector/cute-fat-tailet-gecko-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-4184.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Frog',
          value: 'frog',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-frog-cartoon-vector-illustration_607277-211.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Snake',
          value: 'snake',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-green-snake-cartoon-illustration-animal-nature-concept-isolated-flat-cartoon_138676-2292.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Koala',
          value: 'koala',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-koala-eating-leaf-cartoon-animal-nature-icon-concept-isolated-flat-cartoon-style_138676-2378.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Monkey',
          value: 'monkey',
          imagePath:
              'https://img.freepik.com/free-vector/cute-monkey-surfing_138676-3311.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Whale',
          value: 'whale',
          imagePath:
              'https://img.freepik.com/free-vector/cute-blue-whale-cartoon-icon-illustration_138676-2254.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Penguin',
          value: 'penguin',
          imagePath:
              'https://img.freepik.com/free-vector/cute-penguin-with-fish-cartoon-vector-illustration-animal-wildlife-concept-isolated-vector-flat-cartoon-style_138676-1932.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: '',
          value: '',
          imagePath: ''),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Owl',
          value: 'owl',
          imagePath:
              'https://img.freepik.com/free-vector/cute-owl-holding-coffee-cartoon-icon-illustration_138676-2263.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Animal',
          name: 'Pigeon',
          value: 'pigeon',
          imagePath:
              'https://img.freepik.com/premium-vector/suspicious-pigeon_79591-251.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Family',
          value: 'family',
          imagePath:
              'https://img.freepik.com/premium-vector/happy-cute-family-mom-dad-son-daughter-together_97632-2198.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Tooth',
          value: 'tooth',
          imagePath:
              'https://img.freepik.com/premium-vector/funny-tooth-with-dental-floss-vector-cartoon-character-isolated-background_97231-2337.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Tongue',
          value: 'tongue',
          imagePath: 'https://www.excellentesl4u.com/images/tongue.gif'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Mouth',
          value: 'mouth',
          imagePath:
              'https://png.pngtree.com/png-vector/20191001/ourlarge/pngtree-mouth-with-white-healthy-teeth-icon-cartoon-style-png-image_1771103.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Finger',
          value: 'finger',
          imagePath: 'https://www.excellentesl4u.com/images/fingers.gif'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Eye',
          value: 'eye',
          imagePath:
              'https://media.istockphoto.com/vectors/human-eyeball-eye-color-illustration-vector-id1270550235?b=1&k=20&m=1270550235&s=170667a&w=0&h=4I6et_ZHvif9DrmRX9coet7UaysF7vtaFvzyKE85pkU='),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Astronaut',
          value: 'astronaut',
          imagePath:
              'https://img.freepik.com/free-vector/cute-astronaut-floating-with-rocket-space-cartoon-vector-icon-illustration-science-technology_138676-5426.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Policeman',
          value: 'policeman',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-police-man-vector-illustration_388759-533.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Mechanic',
          value: 'mechanic',
          imagePath:
              'https://img.freepik.com/premium-vector/male-mechanic-cartoon-illustration-people-profession-icon-concept_138676-1898.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Dentist',
          value: 'dentist',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-dentist-with-tooth-cartoon-icon-illustration-dental-health-icon-concept-isolated-flat-cartoon-style_138676-1320.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Farmer',
          value: 'farmer',
          imagePath:
              'https://img.freepik.com/premium-vector/farmer-with-basket-vegetables-ground-fork-cartoon-icon-illustration-people-profession-icon-concept-isolated-flat-cartoon-style_138676-1786.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Scientist',
          value: 'scientist',
          imagePath:
              'https://img.freepik.com/premium-vector/good-scientist-mascot-cartoon-illustration_573232-48.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Fireman',
          value: 'fireman',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-firefighter-cartoon-icon-illustration-people-profession-icon-concept-isolated-flat-cartoon-style_138676-1410.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'People',
          name: 'Nurse',
          value: 'nurse',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-nurse-icon-illustration_138676-1008.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Microwave',
          value: 'microwave',
          imagePath:
              'https://img.freepik.com/premium-vector/vector-cartoon-microwave-icon-microwave-oven-pop-art-style_657802-122.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Spoon',
          value: 'spoon',
          imagePath:
              'https://img.freepik.com/premium-vector/spoon-hand-drawn-cartoon-illustration_288796-1945.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Teapot',
          value: 'teapot',
          imagePath:
              'https://img.freepik.com/premium-vector/teapot-illustration-cartoon_262962-90.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Kettle',
          value: 'kettle',
          imagePath:
              'https://img.freepik.com/premium-vector/kettle-cartoon-icon-illustration_670095-9.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Pyjamas',
          value: 'pyjamas',
          imagePath:
              'https://img.freepik.com/premium-vector/cute-children-characters-pajamas_173653-258.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Wardrobe',
          value: 'wardrobe',
          imagePath:
              'https://img.freepik.com/premium-vector/vector-illustration-open-wardrobe-with-well-organised-tidy-clothes-inside-neat-closet-with-rack-shelves_145154-359.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'TV',
          value: 'tv',
          imagePath:
              'https://img.freepik.com/premium-vector/smart-led-television-display-with-icons-isolated-flat-cartoon_101884-437.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Fireplace',
          value: 'fireplace',
          imagePath:
              'https://img.freepik.com/free-vector/christmas-fireplace-scene-hand-drawn_23-2148343942.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Shampoo',
          value: 'shampoo',
          imagePath:
              'https://img.freepik.com/premium-vector/plastic-bottle-liquid-soap-shampoo-cosmetics-skin-care-personal-hygiene-bathroom-theme-flat-vector-icons_223337-7271.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Soap',
          value: 'soap',
          imagePath:
              'https://img.freepik.com/premium-vector/soap-with-foam_463755-91.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'Bath',
          value: 'bath',
          imagePath:
              'om-vintage-bath-with-water-soap-foam-bubbles-blue-background-retro-bathroom-running-water-flat-cartoon-illustration_567746-1861.jpg'),
      MatchingItem(
          accepting: false,
          topic: 'Home',
          name: 'clock',
          value: 'Clock',
          imagePath:
              'https://img.freepik.com/premium-vector/clock-illustration-icon_100959-112.jpgF'),
    ];
    item1!.removeWhere((item) => item.topic != widget.topic);
    if (item1!.length >= 5) {
      item1 = item1!.sublist(0, 5);
    } else if (item1!.isEmpty) {
      noQuestion = true;
      gameOver = null;
    }
    item2 = List<MatchingItem>.from(item1!);
    item1!.shuffle();
    item2!.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (item1!.isEmpty) {
      gameOver = true;
    }
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Are you sure want to leave?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          willLeave = true;
                          // Navigator.of(context).pop();
                          Navigator.pop(context);
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             TopicPage(topic: widget.topic)),
                          //     (Route<dynamic> route) => false);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Score ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          TextSpan(
                            text: '$score',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: const Color(0xff2b5b89)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!gameOver!)
                    Row(
                      children: [
                        // const Spacer(),
                        Column(
                          children: item1!.map((item) {
                            return Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Draggable<MatchingItem>(
                                data: item,
                                childWhenDragging: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(item.imagePath ?? ''),
                                  radius: 40.0,
                                ),
                                feedback: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(item.imagePath ?? ''),
                                  radius: 45.0,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(item.imagePath ?? ''),
                                  radius: 45,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Column(
                          children: item2!.map((item) {
                            return DragTarget<MatchingItem>(
                              builder: (context, acceptedItems, rejectedItem) =>
                                  Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: item.accepting != null &&
                                            item.accepting == true
                                        ? Colors.grey[400]
                                        : Colors.grey[200]),
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.width / 6,
                                width: MediaQuery.of(context).size.width / 2,
                                margin: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.name ?? '',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              onAccept: (receivedItem) {
                                if (item.value == receivedItem.value) {
                                  player.play("audios/true.mp3");
                                  setState((() {
                                    item1!.remove(receivedItem);
                                    item2!.remove(item);
                                  }));
                                  score = score! + 10;

                                  item.accepting = false;
                                } else {
                                  player.play("audios/false.mp3");
                                  setState(() {
                                    if (score! >= 5) {
                                      score = score! - 5;
                                    }
                                    item.accepting = false;
                                  });
                                }
                              },
                              onWillAccept: (receivedItem) {
                                setState(() {
                                  item.accepting = true;
                                });
                                return true;
                              },
                              onLeave: (receivedItem) {
                                setState((() {
                                  item.accepting = false;
                                }));
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  if (gameOver!)
                    Center(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Game Over',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(result(score!),
                              style: Theme.of(context).textTheme.headline4),
                        )
                      ]),
                    ),
                  if (gameOver!)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 10,
                          decoration: BoxDecoration(
                            color: const Color(0xff2b5b89),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                initGame();
                              });
                            },
                            child: const Text('New Game',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 10,
                          width: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xff2b5b89),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Go home',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String result(int score) {
    if (score == 50) {
      return 'Awesome!';
    }
    return 'Try Again !';
  }
}

class MatchingItem {
  String? name;
  String? imagePath;
  String? value;
  bool? accepting;
  String? topic;

  MatchingItem(
      {this.name,
      this.imagePath,
      this.value,
      this.accepting = false,
      this.topic});
}
