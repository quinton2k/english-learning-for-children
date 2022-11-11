import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TrueFalseGame extends StatelessWidget {
  const TrueFalseGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Center(
          child: Text(
            'True False game',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: QuizWidget(),
      ),
    ));
  }
}

class QuizWidget extends StatefulWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  TrueFalseGameLogic quizLogic = TrueFalseGameLogic();

  List<Widget> scoreKeeper = [];

  int totalCorrect = 0;
  int totalQuestions = 0;

  void checkAnswer(bool value) {
    if (quizLogic.getAnswer() == value) {
      print('right answer');
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      totalCorrect++;
    } else {
      print('wrong answer');
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
    }
    totalQuestions++;
    if (quizLogic.isFinish()) {
      Alert(
          context: context,
          title: 'Finished',
          desc: 'You scored a total of $totalCorrect out of $totalQuestions!',
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Play Again',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            DialogButton(
              color: Colors.black,
              onPressed: () => print('Ve lai man hinh chinh'),
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ]).show();
      quizLogic.reset();
      scoreKeeper.clear();
      totalCorrect = 0;
      totalQuestions = 0;
    } else {
      quizLogic.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
    );
  }
}

class TrueFalseQuestion {
  String? imagePath;
  String? question;
  bool? answer;

  TrueFalseQuestion(this.imagePath, this.question, this.answer);
}

class TrueFalseGameLogic {
  int questionIndex = 0;
  List<TrueFalseQuestion> questions = [
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/little-kid-take-bath-bathtub_97632-7188.jpg',
        'bath mat',
        false),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-carrot-cartoon-carrot-clipart-vector-illustration_160901-2668.jpg',
        'carrot',
        true),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/female-scientist-illustration_52683-31534.jpg',
        'farmer',
        false),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/neon-red-color-solid-background-1920x1080.png',
        'orange',
        false),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/scooter-cartoon-icon-illustration-motorcycle-vehicle-icon-concept-isolated-flat-cartoon-style_138676-1855.jpg',
        'plane',
        false),
  ];

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
