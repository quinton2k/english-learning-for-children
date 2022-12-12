import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_search/word_search.dart';

class WordFindPuzzle extends StatefulWidget {
  final String topic;
  const WordFindPuzzle({Key? key, required this.topic}) : super(key: key);

  @override
  State<WordFindPuzzle> createState() => _WordFindPuzzleState();
}

class _WordFindPuzzleState extends State<WordFindPuzzle> {
  GlobalKey<_WordFindWidgetState> globalKey = GlobalKey();
  late List<WordFindQuestion> listQuestions;
  int? questionsDone;
  @override
  void initState() {
    super.initState();
    questionsDone = 0;
    listQuestions = [
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/vector-illustration-cute-camel-animal_602089-162.jpg",
          answer: "camel",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-teddy-bear-waving-hand-cartoon-icon-illustration_138676-2714.jpg",
          answer: "bear",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/happy-snail-cartoon-illustration_138676-2739.jpg",
          answer: "snail",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-lion-roaring-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-flat_138676-5119.jpg",
          answer: "lion",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-donkey-eating-carrot-cartoon-character-animal-food-isolated_138676-3192.jpg",
          answer: "donkey",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/suspicious-pigeon_79591-251.jpg",
          answer: "pigeon",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-parrot-bird-branch-cartoon-animal-wildlife-icon-concept-isolated-flat-cartoon-style_138676-2176.jpg",
          answer: "parrot",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-owl-holding-coffee-cartoon-icon-illustration_138676-2263.jpg",
          answer: "owl",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/cute-fat-eagle-illustration-suitable-mascot-sticker-tshirt-design_342167-3199.jpg",
          answer: "eagle",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/cute-little-blue-bird-cartoon-flying_188253-3225.jpg",
          answer: "bird",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-honey-bee-flying-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium_138676-6560.jpg",
          answer: "bee",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/cute-black-bat-cartoon-flying-vector-illustration_158784-956.jpg",
          answer: "bat",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/cute-crab-cartoon-character-animal-nature-isolated_138676-3201.jpg",
          answer: "crab",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-octopus-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3628.jpg",
          answer: "octopus",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/premium-vector/vector-illustration-cute-shark-cartoon-hand-drawn-flat-style-isolated-blue-background_611858-127.jpg",
          answer: "shark",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-blue-whale-cartoon-icon-illustration_138676-2254.jpg",
          answer: "whale",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://img.freepik.com/free-vector/cute-dog-cat-friend-cartoon_138676-2432.jpg",
          answer: "pet",
          topic: 'Animal'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/white-color-solid-background-1920x1080.png",
          answer: "white",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/dark-gray-color-solid-background-1920x1080.png",
          answer: "gray",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/forest-green-color-solid-background-1920x1080.png",
          answer: "green",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/neon-red-color-solid-background-1920x1080.png",
          answer: "red",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/orange-color-solid-background-1920x1080.png",
          answer: "orange",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/blue-color-solid-background-1920x1080.png",
          answer: "blue",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/pastel-pink-color-solid-background-1920x1080.png",
          answer: "pink",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/purple-color-solid-background-1920x1080.png",
          answer: "purple",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              "https://htmlcolorcodes.com/assets/images/colors/dark-brown-color-solid-background-1920x1080.png",
          answer: "brown",
          topic: 'Color'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/bowl-blue-vector-illustration-empty-plate-soup-rice-porridge_421321-235.jpg',
          answer: 'bowl',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/fridge-refrigerator-icon-comic-style-freezer-container-vector-cartoon-illustration-pictogram-splash-effect_157943-4397.jpg',
          answer: 'fridge',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/pan-cartoon-vector-icon-illustration_670095-41.jpg',
          answer: 'pan',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/plates-cartoon-vector-illustration_345007-241.jpg',
          answer: 'plate',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/happy-cute-kid-boy-use-mirror-morning_97632-1104.jpg',
          answer: 'mirror',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/stair-wooden-bunk-bed-vector-illustration_28296-50.jpg',
          answer: 'bunk',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/cute-children-characters-pajamas_173653-258.jpg',
          answer: 'pyjamas',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/pillows_1308-16584.jpg',
          answer: 'pillow',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/clock-illustration-icon_100959-112.jpg',
          answer: 'clock',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/classic-table-lamp-with-plug-isolated-white-background-vector-trendy-illustration_460582-586.jpg',
          answer: 'lamp',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/sofa-armchair-living-room-vector-icon-illustration-comfortable-rest-furniture-sofa-chair_722324-195.jpg',
          answer: 'sofa',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/plant-collection-set-flat-cartoon-style_138676-2640.jpg',
          answer: 'plant',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/flush-toilet_60352-2676.jpg',
          answer: 'toilet',
          topic: 'Home'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/drama-symbol_1284-3552.jpg',
          answer: 'actor',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/cleaning-service-cartoon-with-cute-pose-icon-illustration_244307-545.jpg',
          answer: 'cleaner',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/farmer-with-basket-vegetables-ground-fork-cartoon-icon-illustration-people-profession-icon-concept-isolated-flat-cartoon-style_138676-1786.jpg',
          answer: 'farmer',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/cute-boy-chef-holding-cloche-food-spatula-cartoon-vector-icon-illustration_480044-376.jpg',
          answer: 'cook',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/veterinarian-with-cat-dog-people-animal_138676-2037.jpg',
          answer: 'vet',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/happy-cute-family-mom-dad-son-daughter-together_97632-2198.jpg',
          answer: 'family',
          topic: 'People'),
      WordFindQuestion(
          pathImage: 'https://www.excellentesl4u.com/images/hand.gif',
          answer: 'hand',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://png.vector.me/files/images/1/4/146185/part_outline_human_cartoon_free_body_parts_leg_biswajyotim_legs.jpg',
          answer: 'leg',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://media.istockphoto.com/vectors/human-eyeball-eye-color-illustration-vector-id1270550235?b=1&k=20&m=1270550235&s=170667a&w=0&h=4I6et_ZHvif9DrmRX9coet7UaysF7vtaFvzyKE85pkU=',
          answer: 'eye',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/light-skinned-human-ear-white-isolated-background_535126-38.jpg',
          answer: 'ear',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://png.pngtree.com/png-vector/20190130/ourlarge/pngtree-cartoon-pop-style-lip-material-lipspop-style-lipslipssexy-png-image_645091.jpg',
          answer: 'lip',
          topic: 'People'),
      WordFindQuestion(
          pathImage: 'https://www.excellentesl4u.com/images/thumb.gif',
          answer: 'thumb',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/running-woman-athlete-is-winner-gold-medal-sport-competition-leadership-concept-young-joyful-african-american-sporty-girl-with-champion-trophy-flat-vector-cartoon-illustration_534430-278.jpg',
          answer: 'athlete',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/male-artist-painter-cartoon-illustration-people-profession-icon-concept_138676-1900.jpg',
          answer: 'artist',
          topic: 'People'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/chocolate-cookies-cartoon-icon-illustration-food-snack-icon-concept-isolated-flat-cartoon-style_138676-2568.jpg',
          answer: 'biscuit',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/set-soft-drink-carbonated-water-plastic-alumunium-packaging-flat-cartoon-illustration-isolated_400474-47.jpg',
          answer: 'soda',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/chips-bowl-cartoon-illustration-vector-image-flat-design_503002-1.jpg',
          answer: 'crisp',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/bread-cartoon-vector-icons-illustration-flat-cartoon-concept_480044-1246.jpg',
          answer: 'bread',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/cooking-boiling-soup-gas-stove-saucepan-with-boiling-soup-opened-lid-gas-stove-fire-steam-vector-illustration-cartoon-flat-illustration_106796-1049.jpg',
          answer: 'soup',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/refined-loose-sugar-bowl-hand-takes-cube-sugar_168129-980.jpg',
          answer: 'sugar',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/set-different-fruit-vegetable-fresh-juices-glasses_267448-23.jpg',
          answer: 'juice',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/sausage-cartoon-vector-illustration_242622-168.jpg',
          answer: 'sausage',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/carrot-vegetable-cartoon-vector-icon-illustration-food-objects-icon-concept-isolated-premium-vector_138676-4464.jpg',
          answer: 'carrot',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/red-onion-vegetable-cartoon-vector-icon-illustration-food-nature-icon-concept-isolated-premium-flat_138676-5142.jpg',
          answer: 'onion',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/slice-whole-tomato-cartoon-vector-illustration-fresh-red-tomatoes-flat-icon-outline_385450-1188.jpg',
          answer: 'tomato',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/honey-jar-cartoon-flat-food-vector_374761-233.jpg',
          answer: 'honey',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/whole-chicken-egg_565492-805.jpg',
          answer: 'egg',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/premium-vector/slice-whole-lemon-cartoon-vector-illustration-fresh-lemon-fruit-flat-icon-outline_385450-1468.jpg',
          answer: 'lemon',
          topic: 'Food'),
      WordFindQuestion(
          pathImage:
              'https://img.freepik.com/free-vector/red-onion-vegetable-cartoon-vector-icon-illustration-food-nature-icon-concept-isolated-premium-flat_138676-5142.jpg',
          answer: 'onion',
          topic: 'Food'),
      WordFindQuestion(pathImage: '', answer: '', topic: 'School'),
      WordFindQuestion(pathImage: '', answer: '', topic: 'Sport'),
      WordFindQuestion(pathImage: '', answer: '', topic: 'Toy'),
      WordFindQuestion(pathImage: '', answer: '', topic: 'Vehicle'),
      WordFindQuestion(pathImage: '', answer: '', topic: 'Verb'),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                          Navigator.pop(context);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      child: WordFindWidget(
                        constraints.biggest,
                        listQuestions
                            .map((question) => question.clone())
                            .toList(),
                        key: globalKey,
                        topic: widget.topic,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordFindWidget extends StatefulWidget {
  final String topic;
  Size size;
  WordFindWidget(this.size, this.listQuestions, {Key? key, required this.topic})
      : super(key: key);
  late List<WordFindQuestion> listQuestions;
  @override
  State<WordFindWidget> createState() => _WordFindWidgetState();
}

class _WordFindWidgetState extends State<WordFindWidget> {
  late Size size;
  late List<WordFindQuestion> listQuestions;
  late int indexQuestion = 0;
  int hintCount = 3;
  late bool gameOver;

  initGame() {
    gameOver = false;
    size = widget.size;
    listQuestions = widget.listQuestions;
    listQuestions.removeWhere((question) => question.topic != widget.topic);
    listQuestions.shuffle();
    if (listQuestions.length > 3) {
      listQuestions = listQuestions.sublist(0, 3);
    }
    print('So cau hoi: ${listQuestions.length}');

    for (var question in listQuestions) {
      print('topicL ${question.topic}');
      print('image: ${question.pathImage}');
    }
    generatePuzzle(loop: listQuestions);
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  Widget renderGameOver() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Game Over',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    // color: Colors.red,
                  )),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Congrats',
            style: Theme.of(context).textTheme.headline4,
          ),
          // child: Text('Congratulation',
          //     style: TextStyle(color: Color(0xffb2955d))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 10,
              width: 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 126, 103, 57),
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
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];
    return gameOver
        ? renderGameOver()
        : SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                        maxWidth: size.width / 2 * 1.5,
                        maxHeight: size.width,
                      ),
                      child: Image.network(
                        currentQuestion.pathImage ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: currentQuestion.puzzles.map((puzzle) {
                          Color? color = Color.fromARGB(255, 196, 187, 187);

                          if (currentQuestion.isDone) {
                            color = Colors.green[300];
                          } else if (puzzle.hintShow) {
                            color = Colors.yellow[100];
                          } else if (currentQuestion.isFull &&
                              !currentQuestion.isDone) {
                            color = Colors.red[100];
                          }
                          return InkWell(
                            onTap: () {
                              if (puzzle.hintShow || currentQuestion.isDone) {
                                return;
                              }

                              currentQuestion.isFull = false;
                              puzzle.clearValue();
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              width: constraints.biggest.width / 7 - 6,
                              height: constraints.biggest.width / 7 - 6,
                              margin: const EdgeInsets.all(3),
                              child: Text(
                                  puzzle.currentValue?.toUpperCase() ?? ''),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: 16,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool statusBtn = currentQuestion.puzzles.indexWhere(
                              (puzzle) => puzzle.currentIndex == index) >=
                          0;
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          Color? color = statusBtn
                              ? Color.fromARGB(255, 188, 171, 135)
                              : Color.fromARGB(255, 247, 238, 219);
                          return Container(
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  if (!statusBtn) {
                                    setButtonClick(index);
                                  }
                                },
                                child: Text(
                                  currentQuestion.arrayBtns[index]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 126, 103, 57)),
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  void generatePuzzle(
      {List<WordFindQuestion>? loop, bool next = false, bool left = false}) {
    if (loop != null) {
      indexQuestion = 0;
      listQuestions = <WordFindQuestion>[];
      listQuestions.addAll(loop);
    } else {
      if (next && indexQuestion < listQuestions.length - 1) {
        indexQuestion += 1;
      } else if (left && indexQuestion > 0) {
        indexQuestion -= 1;
      } else if (indexQuestion >= listQuestions.length - 1) {
        gameOver = true;
        return;
      }

      setState(() {});

      if (listQuestions[indexQuestion].isDone) {
        return;
      }
    }
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];

    setState(() {});

    final List<String> wl = [currentQuestion.answer ?? ''];
    final WSSettings ws = WSSettings(
        width: 16,
        height: 1,
        orientations: List.from([
          WSOrientation.horizontal,
        ]));

    final WordSearch wordSearch = WordSearch();

    final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);

    if (newPuzzle.errors.isEmpty) {
      currentQuestion.arrayBtns =
          newPuzzle.puzzle.expand((list) => list).toList();
      currentQuestion.arrayBtns.shuffle();

      bool isDone = currentQuestion.isDone;

      if (!isDone) {
        currentQuestion.puzzles = List.generate(
          wl[0].split("").length,
          (index) => WordFindChar(
            correctValue: currentQuestion.answer!.split("")[index],
          ),
        );
      }
    }
  }

  generateHint() async {
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];
    List<WordFindChar> puzzleNoHints = currentQuestion.puzzles
        .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
        .toList();

    if (puzzleNoHints.isNotEmpty) {
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;
      // print("hint $indexHint");

      currentQuestion.puzzles = currentQuestion.puzzles.map((puzzle) {
        if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

        if (indexHint == countTemp - 1 && hintCount > 0) {
          hintCount -= 1;
          print(hintCount);
          puzzle.hintShow = true;
          puzzle.currentValue = puzzle.correctValue;
          puzzle.currentIndex = currentQuestion.arrayBtns
              .indexWhere((btn) => btn == puzzle.correctValue);
        }

        return puzzle;
      }).toList();

      if (currentQuestion.fieldCompleteCorrect()) {
        currentQuestion.isDone = true;
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
        generatePuzzle(next: true);
      }
    }
    setState(() {});
  }

  Future<void> setButtonClick(int index) async {
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];

    int currentIndexEmpty = currentQuestion.puzzles
        .indexWhere((puzzle) => puzzle.currentValue == null);
    if (currentIndexEmpty >= 0) {
      currentQuestion.puzzles[currentIndexEmpty].currentIndex = index;
      currentQuestion.puzzles[currentIndexEmpty].currentValue =
          currentQuestion.arrayBtns[index];

      if (currentQuestion.fieldCompleteCorrect()) {
        currentQuestion.isDone = true;

        setState(() {});

        await Future.delayed(const Duration(seconds: 1));
        generatePuzzle(next: true);
      }

      setState(() {});
    }
  }
}

class WordFindQuestion {
  // String? question;
  String? pathImage;
  String? answer;
  String? topic;
  bool isDone = false;
  bool isFull = false;
  List<WordFindChar> puzzles = <WordFindChar>[];
  List<String> arrayBtns = <String>[];

  WordFindQuestion(
      {required this.pathImage,
      // required this.question,
      required this.answer,
      required this.topic});
  void setWordFindChar(List<WordFindChar> puzzles) => this.puzzles = puzzles;

  void isDoneSet() => isDone = true;

  bool fieldCompleteCorrect() {
    bool complete =
        puzzles.where((puzzle) => puzzle.correctValue == null).isEmpty;
    if (!complete) {
      isFull = false;
      return complete;
    }
    isFull = true;
    String answeredString =
        puzzles.map((puzzle) => puzzle.currentValue).join("");

    return answeredString == answer;
  }

  WordFindQuestion clone() {
    return WordFindQuestion(
      answer: answer,
      pathImage: pathImage,
      // question: question,
      topic: topic,
    );
  }
}

class WordFindChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  late bool hintShow;

  WordFindChar({
    this.hintShow = false,
    required this.correctValue,
  });

  getCurrentValue() {
    if (correctValue != '') {
      return currentValue;
    }
    if (hintShow) return correctValue;
  }

  void clearValue() {
    currentIndex = -1;
    currentValue = null;
  }
}
