import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:word_search/word_search.dart';

//TODO: fixing UI + playing audio
class WordFindPuzzle extends StatefulWidget {
  const WordFindPuzzle({Key? key}) : super(key: key);

  @override
  State<WordFindPuzzle> createState() => _WordFindPuzzleState();
}

class _WordFindPuzzleState extends State<WordFindPuzzle> {
  GlobalKey<_WordFindWidgetState> globalKey = GlobalKey();

  late List<WordFindQuestion> listQuestions;

  bool? gameOver;
  int? questionsDone;
  @override
  void initState() {
    super.initState();
    gameOver = false;
    questionsDone = 0;
    listQuestions = [
      WordFindQuestion(
        pathImage: "https://img.freepik.com/free-vector/frying-pan-cooking-utensils-graphic_53876-8475.jpg",
        question: "What is this ?",
        answer: "pan",
      ),
      WordFindQuestion(
        pathImage:
            "https://img.freepik.com/premium-vector/set-old-red-telephone-logos_409025-98.jpg",
        question: "How do you call this ?",
        answer: "phone",
      ),
      WordFindQuestion(
        pathImage: "https://img.freepik.com/premium-vector/pink-towel-hanging-cartoon-textile-handcloth-icon_543062-2765.jpg",
        question: "What is it ?",
        answer: "towel",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Game điền từ'),
      //   backgroundColor: const Color(0xff4C7352),
      // ),
      body: SafeArea(
        child: Container(
          child: Container(
            child: Column(
              children: [
                if (!gameOver!)
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          color: Colors.blue,
                          child: WordFindWidget(
                            constraints.biggest,
                            listQuestions
                                .map((question) => question.clone())
                                .toList(),
                            key: globalKey,
                          ),
                        );
                      },
                    ),
                  ),
                if (!gameOver!)
                  Container(
                    color: Colors.blue,
                    width: 450,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        globalKey.currentState!.generatePuzzle(
                            loop: listQuestions
                                .map((question) => question.clone())
                                .toList());
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 24.0,
                      ),
                      label: const Text('Delete'),
                    ),
                  ),
                if (gameOver!)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Game Over',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Congratulation',
                            style: Theme.of(context).textTheme.headline3),
                      )
                    ]),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WordFindWidget extends StatefulWidget {
  Size size;
  WordFindWidget(this.size, this.listQuestions, {Key? key}) : super(key: key);
  late List<WordFindQuestion> listQuestions;
  @override
  State<WordFindWidget> createState() => _WordFindWidgetState();
}

class _WordFindWidgetState extends State<WordFindWidget> {
  late Size size;
  late List<WordFindQuestion> listQuestions;
  late int indexQuestion = 0;
  int hintCount = 3;
  // ignore: annotate_overrides
  void initState() {
    super.initState();
    size = widget.size;
    listQuestions = widget.listQuestions;
    generatePuzzle();
  }

  @override
  Widget build(BuildContext context) {
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];
    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  label: Text("Hint: $hintCount"),
                  icon: const Icon(Icons.contact_support_sharp),
                  onPressed: () {
                    generateHint();
                  },
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        generatePuzzle(left: true);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        generatePuzzle(next: true);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                  currentQuestion.pathImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              currentQuestion.question,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: currentQuestion.puzzles.map((puzzle) {
                    Color? color = const Color(0xffFFFFFF);

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
                        if (puzzle.hintShow || currentQuestion.isDone) return;

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
                        child: Text(puzzle.currentValue?.toUpperCase() ?? ''),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 16,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool statusBtn = currentQuestion.puzzles
                        .indexWhere((puzzle) => puzzle.currentIndex == index) >=
                    0;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    Color? color =
                        statusBtn ? Colors.lightGreen : Colors.white70;
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
                            currentQuestion.arrayBtns[index].toUpperCase(),
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
        return;
      }

      setState(() {});

      if (listQuestions[indexQuestion].isDone) {
        return;
      }
    }
    WordFindQuestion currentQuestion = listQuestions[indexQuestion];

    setState(() {});

    final List<String> wl = [currentQuestion.answer];
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
            correctValue: currentQuestion.answer.split("")[index],
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

    if (puzzleNoHints.length > 0) {
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
  late String question;
  late String pathImage;
  late String answer;
  bool isDone = false;
  bool isFull = false;
  List<WordFindChar> puzzles = <WordFindChar>[];
  List<String> arrayBtns = <String>[];

  WordFindQuestion({
    required this.pathImage,
    required this.question,
    required this.answer,
  });
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
      question: question,
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
