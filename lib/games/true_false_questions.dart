import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learning_english/screens/topic_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TrueFalseGame extends StatelessWidget {
  final String topic;
  const TrueFalseGame({Key? key, required this.topic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text(
          'True False game',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: QuizWidget(topic: topic),
      ),
    ));
  }
}

class QuizWidget extends StatefulWidget {
  final String topic;
  const QuizWidget({Key? key, required this.topic}) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  var player = AudioCache();
  late TrueFalseGameLogic quizLogic;
  List<Widget> scoreKeeper = [];

  int totalCorrect = 0;
  late int totalQuestions;

  @override
  void initState() {
    super.initState();
    quizLogic = TrueFalseGameLogic(widget.topic);
    totalQuestions = quizLogic.questions.length;
  }

  void checkAnswer(bool value) {
    if (quizLogic.getAnswer() == value) {
      print('right answer');
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      totalCorrect++;
      player.play("audios/true.mp3");
    } else {
      print('wrong answer');
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      player.play("audios/false.mp3");
    }
    if (quizLogic.isFinish()) {
      Alert(
          context: context,
          title: 'Finished',
          desc: 'You scored a total of $totalCorrect out of $totalQuestions!',
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrueFalseGame(topic: widget.topic)),
                  (Route<dynamic> route) => false,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => Navigator.pushReplacement,
                // ));
              },
              child: const Text(
                'Play Again',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            DialogButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TopicPage(topic: widget.topic),
                ));
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ]).show();
    } else {
      Future.delayed(const Duration(milliseconds: 900));
      quizLogic.nextQuestion();
    }
  }

  Widget renderNoQuestion() {
    return Container(
      height: 1050,
      width: 500,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: const Center(child: Text("Question will be updated soon")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return totalQuestions == 0
        ? renderNoQuestion()
        : WillPopScope(
            onWillPop: () async {
              bool willLeave = false;
              // show the confirm dialog
              await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text('Are you sure want to leave?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                willLeave = true;
                                // Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TopicPage(topic: widget.topic),
                                ));
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('No'))
                        ],
                      ));
              return willLeave;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blue[200],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  quizLogic.getImagePath() ?? '',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              quizLogic.getQuestion() ?? '',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  checkAnswer(true);
                                });
                              },
                              icon: const Icon(Icons.check_sharp),
                              label: const Text('True')),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  checkAnswer(false);
                                });
                              },
                              icon: const Icon(Icons.clear),
                              label: const Text('False')),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: scoreKeeper,
                  ),
                ),
              ],
            ),
          );
  }
}

class TrueFalseQuestion {
  String? imagePath;
  String? question;
  bool? answer;
  String? topic;
  TrueFalseQuestion(this.imagePath, this.question, this.answer, this.topic);
}

class TrueFalseGameLogic {
  final String topic;

  int questionIndex = 0;
  List<TrueFalseQuestion> questions = [
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-goldfish-swimming-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium_138676-6481.jpg',
        'Goldfish',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-crab-cartoon-character-animal-nature-isolated_138676-3201.jpg',
        'Crab',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-octopus-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3628.jpg',
        'Fish',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-monkey-surfing_138676-3311.jpg',
        'Monkey',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-sloth-sleeping-with-coffee-cup-cartoon-vector-icon-illustration-animal-drink-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3491.jpg',
        'Sloth',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-monkey-surfing_138676-3311.jpg',
        'Sheep',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-cow-dancing-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-flat-cartoon_138676-4348.jpg',
        'Buffalo',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-horse-walking-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium_138676-4712.jpg',
        'Horse',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-panda-with-bamboo_138676-3053.jpg',
        'Panda',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/pink-towel-hanging-cartoon-textile-handcloth-icon_543062-2765.jpg',
        'Towel',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cartoon-toothpaste-tube-with-squeezed-out-paste-vector-hand-drawn-illustration_20412-759.jpg',
        'Tootbrush',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/toothbrush-with-toothpaste-cleaning-teeth-oral-hygiene-doodle-line-cartoon_253359-2373.jpg',
        'Tootbrush',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-soap-cartoon-icon-illustration-healthy-mascot-character-health-medical-icon-concept-isolated_138676-887.jpg',
        'Shampoo',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/table-cartoon_119631-412.jpg',
        'Table',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-illustration-analogue-retro-tv-with-antenna-orange-plastic-body_501907-363.jpg',
        'PC',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/sofa-couch-red-colorful-cartoon-illustration-vector-comfortable-lounge-interior-design-isolated-white-background-modern-model-settee-icon_311563-463.jpg',
        'Sofa',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/mirror-cartoon-design_274619-1412.jpg',
        'Mirror',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/little-kid-take-bath-bathtub_97632-7188.jpg',
        'bath mat',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-carrot-cartoon-carrot-clipart-vector-illustration_160901-2668.jpg',
        'carrot',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/female-scientist-illustration_52683-31534.jpg',
        'farmer',
        false,
        'People'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/neon-red-color-solid-background-1920x1080.png',
        'orange',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/scooter-cartoon-icon-illustration-motorcycle-vehicle-icon-concept-isolated-flat-cartoon-style_138676-1855.jpg',
        'plane',
        false,
        'Vehicle'),
  ];

  void shuffle() {
    return questions.shuffle();
  }

  TrueFalseGameLogic(this.topic) {
    questions.removeWhere((question) => question.topic != topic);
    shuffle();
    if (questions.length >= 5) {
      questions = questions.sublist(0, 5);
    }
  }

  String? getQuestion() {
    return questions[questionIndex].question;
  }

  bool? getAnswer() {
    return questions[questionIndex].answer;
  }

  String? getImagePath() {
    return questions[questionIndex].imagePath;
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex += 1;
    }
  }

  bool isFinish() {
    if (questionIndex >= questions.length - 1) {
      return true;
    }
    return false;
  }

  void reset() {
    questionIndex = 0;
  }
}
