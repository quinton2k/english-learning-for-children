import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DragNDropWidget extends StatefulWidget {
  const DragNDropWidget({Key? key}) : super(key: key);

  @override
  State<DragNDropWidget> createState() => _DragNDropWidgetState();
}

class _DragNDropWidgetState extends State<DragNDropWidget> {
  var player = AudioCache();
  List<DnDModel>? item1;
  List<DnDModel>? item2;
  int? score;
  bool? gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    item1 = [
      DnDModel(
          value: 'subway',
          name: 'Subway',
          imagePath:
              'https://img.freepik.com/premium-vector/metro-icon-comic-style-train-subway-cartoon-vector-illustration-white-isolated-background-railroad-cargo-splash-effect-business-concept_157943-6157.jpg'),
      DnDModel(
          value: 'helicopter',
          name: 'Helicopter',
          imagePath:
              'https://img.freepik.com/free-vector/helicopter-cartoon-vector-icon-illustration-air-transportation-icon-concept-isolated-vector-flat-cartoon-style_138676-2511.jpg'),
      DnDModel(
          value: 'taxi',
          name: 'Taxi',
          imagePath:
              'https://img.freepik.com/premium-vector/taxi-cartoon-vector-icon-illustration_480044-725.jpg'),
      DnDModel(
          value: 'bicycle',
          name: 'Bicycle',
          imagePath:
              'https://img.freepik.com/free-vector/bicycle-sport-recreation_138676-2035.jpg'),
    ];
    item2 = List<DnDModel>.from(item1!);
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
    return Scaffold(
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
                            .copyWith(color: Colors.teal),
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
                          child: Draggable<DnDModel>(
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
                              radius: 50.0,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(item.imagePath ?? ''),
                              minRadius: 50,
                              maxRadius: 50,
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
                        return DragTarget<DnDModel>(
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
                              setState((() {
                                item1!.remove(receivedItem);
                                item2!.remove(item);
                              }));
                              score = score! + 10;

                              item.accepting = false;
                            } else {
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(result(),
                          style: Theme.of(context).textTheme.headline4),
                    )
                  ]),
                ),
              if (gameOver!)
                Container(
                  height: MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                    color: Colors.teal,
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
            ],
          ),
        ),
      ),
    );
  }

  String result() {
    if (score == 40) {
      return 'Awesome!';
    }
    return 'Try for better score :P';
  }
}

class DnDModel {
  String? name;
  String? imagePath;
  String? value;
  bool? accepting;

  DnDModel({this.name, this.imagePath, this.value, this.accepting = false});
}
