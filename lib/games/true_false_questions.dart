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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
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
  late bool gameOver;
  List<Widget> scoreKeeper = [];

  int totalCorrect = 0;
  late int totalQuestions;

  initGame() {
    gameOver = false;
    quizLogic = TrueFalseGameLogic(widget.topic);
    totalQuestions = quizLogic.questions.length;
  }

  @override
  void initState() {
    super.initState();
    initGame();
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
      gameOver = true;
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
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text('Are you sure want to leave?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                willLeave = true;
                                Navigator.pop(context);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) =>
                                //       TopicPage(topic: widget.topic),
                                // ));
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
                Center(
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
                                text: (totalCorrect * 10).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: const Color(0xffb46c6d)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (gameOver)
                        if ((totalCorrect * 10).toString() == '50')
                          Center(
                            child: Text(
                              'Congrats',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                      if ((totalCorrect * 10).toString() != '50' && gameOver)
                        Center(
                          child: Text(
                            'You could do better 😊',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      if (gameOver)
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb46c6d),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        initGame();
                                        scoreKeeper.clear();
                                        totalCorrect = 0;
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
                                  height:
                                      MediaQuery.of(context).size.width / 10,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffb46c6d),
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
                        ),
                    ],
                  ),
                ),
                if (!gameOver)
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
                if (!gameOver)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(213, 246, 223, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    checkAnswer(true);
                                  });
                                },
                                icon: const Icon(
                                  Icons.check_sharp,
                                  size: 45,
                                  color: Color(0xff417c66),
                                ),
                                label: const Text(
                                  'True',
                                  style: TextStyle(
                                      fontSize: 25, color: Color(0xff417c66)),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 249, 201, 198),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  checkAnswer(false);
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 45,
                                color: Color(0xffd35e4a),
                              ),
                              label: const Text('False',
                                  style: TextStyle(
                                      color: Color(0xffd35e4a), fontSize: 25)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!gameOver)
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

  List<TrueFalseQuestion> questions = [
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-golden-fish-with-beautiful-tail_451085-495.jpg',
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
        'Octopus',
        true,
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
        'Kangaroo',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-cow-sitting-eating-grass-cartoon-vector-icon-illustration-animal-nature-icon-isolated-flat_138676-4780.jpg',
        'Buffalo',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-lion-roaring-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium-flat_138676-5119.jpg',
        'Tiger',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-horse-walking-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium_138676-4712.jpg',
        'Horse',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-panda-with-bamboo_138676-3053.jpg',
        'Bear',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-teddy-bear-waving-hand-cartoon-icon-illustration_138676-2714.jpg',
        'Panda',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-crocodile-waving-hand-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated_138676-6015.jpg',
        'Lizard',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/drawn-marine-crawfish-illustration_23-2149238145.jpg',
        'Shrimp',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-seahorse-cartoon-character-animal-nature-isolated_138676-3200.jpg',
        'Sea lion',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-illustration-cute-shark-cartoon-hand-drawn-flat-style-isolated-blue-background_611858-127.jpg',
        'Dolphin',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-dolphin-cartoon-illustration_138676-3212.jpg',
        'Dolphin',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-owl-holding-coffee-cartoon-icon-illustration_138676-2263.jpg',
        'Eagle',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-black-bat-cartoon-flying-vector-illustration_158784-956.jpg',
        'Bird',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-parrot-bird-branch-cartoon-animal-wildlife-icon-concept-isolated-flat-cartoon-style_138676-2176.jpg',
        'Parrot',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-honey-bee-flying-cartoon-vector-icon-illustration-animal-nature-icon-concept-isolated-premium_138676-6560.jpg',
        'Bird',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-green-snake-cartoon-illustration-animal-nature-concept-isolated-flat-cartoon_138676-2292.jpg',
        'Snake',
        true,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-chicken-holding-fried-chicken-cartoon-icon-illustration_138676-2840.jpg',
        'Duck',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-rat-mouse-hold-cheese-icon-illustration-animal-icon-concept-isolated-flat-cartoon-style_138676-1260.jpg',
        'Hamster',
        false,
        'Animal'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/modern-landline-phone-concept_118813-1736.jpg',
        'Mobile phone',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/smart-led-television-display-with-icons-isolated-flat-cartoon_101884-437.jpg',
        'Computer',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/wooden-table-flat-illustration-table-vector-flat-table-furniture-interior-house-home-elements_677428-350.jpg',
        'Sofa',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-isolated-object-illustration-oral-dental-care-toothpaste_311865-9431.jpg',
        'Toothbrush',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/tissue-paper-cartoon-vector-illustration-toilet-tape-kitchen-paper-towel-flat-icon-outline_385450-1324.jpg',
        'Toilet',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/stair-wooden-bunk-bed-vector-illustration_28296-50.jpg',
        'Double bed',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/fever-girl-shivering-blanket_1308-78269.jpg',
        'Pillow',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-cartoon-microwave-icon-microwave-oven-pop-art-style_657802-122.jpg',
        'Rice cooker',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/two-type-fork-flat-illustration_697324-8909.jpg',
        'Knife',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/pan-cartoon-vector-icon-illustration_670095-41.jpg',
        'Plate',
        false,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/fridge-refrigerator-icon-comic-style-freezer-container-vector-cartoon-illustration-pictogram-splash-effect_157943-4397.jpg',
        'Fridge',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/open-dishwasher-with-clean-dishes-vector-illustration_658424-135.jpg',
        'Dishwasher',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/illustrator-bed-isolated_65947-6.jpg',
        'Single bed',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/classic-table-lamp-with-plug-isolated-white-background-vector-trendy-illustration_460582-586.jpg',
        'Lamp',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/family-photo-frame-hanging-wall-set_277904-3751.jpg',
        'Picture',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/hanging-bath-towel-cute-blue-soft-textile-isolated-white-background_81894-6007.jpg',
        'Towel',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/shower-head-vector-bathroom-equipment-isolated-icon_88813-1209.jpg',
        'Shower',
        true,
        'Home'),
    TrueFalseQuestion(
        'https://media.istockphoto.com/vectors/human-eyeball-eye-color-illustration-vector-id1270550235?b=1&k=20&m=1270550235&s=170667a&w=0&h=4I6et_ZHvif9DrmRX9coet7UaysF7vtaFvzyKE85pkU=',
        'Eye',
        true,
        'People'),
    TrueFalseQuestion('https://www.excellentesl4u.com/images/hair.gif', 'Hair',
        true, 'People'),
    TrueFalseQuestion(
        'https://media.baamboozle.com/uploads/images/463077/1631980501_30073.png',
        'Knee',
        true,
        'People'),
    TrueFalseQuestion(
        'https://t4.ftcdn.net/jpg/00/85/40/99/360_F_85409964_pDPOtsYW2vOmwPlJnyOsyNsCvunR8FCn.jpg',
        'Arm',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/cute-boy-driving-plane-cartoon_138676-2279.jpg',
        'Pilot',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-illustration-cartoon-students_29937-2090.jpg',
        'Student',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/boy-is-playing-guitar-musical-performance-vector-illustration-cartoon-style_454510-240.jpg',
        'Musician',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-teacher-cartoon_96373-117.jpg',
        'Teacher',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-firefighter-cartoon-icon-illustration-people-profession-icon-concept-isolated-flat-cartoon-style_138676-1410.jpg',
        'Fireman',
        true,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/soldier-army-with-gun-cartoon-icon-illustration-people-profession-icon-concept-isolated-flat-cartoon-style_138676-1785.jpg',
        'Police',
        false,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/illustration-cute-male-doctor-thumbs-up-kawaii-vector-cartoon-character-design_380474-37.jpg',
        'Scientist',
        false,
        'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-dentist-with-tooth-cartoon-icon-illustration-dental-health-icon-concept-isolated-flat-cartoon-style_138676-1320.jpg',
        'Doctor',
        false,
        'People'),
    TrueFalseQuestion('https://www.excellentesl4u.com/images/toes.gif',
        'Big toe', false, 'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-kawaii-teeth-characters_153791-211.jpg',
        'Tooth',
        false,
        'People'),
    TrueFalseQuestion('https://www.excellentesl4u.com/images/tongue.gif',
        'Mouth', false, 'People'),
    TrueFalseQuestion('https://www.excellentesl4u.com/images/thumb.gif',
        'Finger', false, 'People'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/funny-tooth-with-dental-floss-vector-cartoon-character-isolated-background_97231-2337.jpg',
        'Teeth',
        false,
        'People'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/forest-green-color-solid-background-1920x1080.png',
        'Blue',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/blue-color-solid-background-1920x1080.png',
        'Green',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/purple-color-solid-background-1920x1080.png',
        'Indigo',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/pastel-pink-color-solid-background-1920x1080.png',
        'Gold',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/silver-color-solid-background-1920x1080.png',
        'White',
        false,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/dark-brown-color-solid-background-1920x1080.png',
        'Brown',
        true,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/neon-red-color-solid-background-1920x1080.png',
        'Red',
        true,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/orange-color-solid-background-1920x1080.png',
        'Orange',
        true,
        'Color'),
    TrueFalseQuestion(
        'https://htmlcolorcodes.com/assets/images/colors/bright-yellow-color-solid-background-1920x1080.png',
        'Yellow',
        true,
        'Color'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/glass-water-cartoon-illustration-fresh-healthy-water-vector-illustration_597063-177.jpg',
        'Water',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/sausage-cartoon-vector-illustration_242622-168.jpg',
        'Sausage',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/flying-doughnut-melted-cartoon-icon-illustration_138676-2452.jpg',
        'Donut',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/meat-cartoon-icon-illustration-animal-food-icon-concept-isolated-flat-cartoon-style_138676-2151.jpg',
        'Meat',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/apple-fruit-cartoon-icon-illustration-food-fruit-icon-concept-isolated-flat-cartoon-style_138676-2922.jpg',
        'Apple',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/avocado-whole-sliced-icon-vector_725118-163.jpg',
        'Avocado',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/strawberry-yogurt-with-spoon-inside-white-background_61747-103.jpg',
        'Yogurt',
        true,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/vector-lime-slice-half-whole-leaves-green-cartoon-style_660715-28.jpg',
        'Lemon',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/slice-whole-lemon-cartoon-vector-illustration-fresh-lemon-fruit-flat-icon-outline_385450-1468.jpg',
        'Lime',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/mango-fruit-cartoon-icon-illustration_670095-27.jpg',
        'Orange',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/milk-carton-boxes-with-milk-glass_385450-176.jpg',
        'Cheese',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/cute-cheese-burger-cartoon-illustration-delicious-fast-food-hamburger-with-cheese-meat-vector_597063-173.jpg',
        'Hot dog',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/free-vector/hotdog-cartoon-icon-illustration_138676-2449.jpg',
        'Hamburger',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/fast-food-sandwich-cartoon-flat-cartoon-illustration_403370-754.jpg',
        'Bread',
        false,
        'Food'),
    TrueFalseQuestion(
        'https://img.freepik.com/premium-vector/hand-drawn-blackforest-flavor-cake-slice-plate_661036-6.jpg',
        'Chocolate',
        false,
        'Food'),
  ];
}
