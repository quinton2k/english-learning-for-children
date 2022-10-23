import 'package:flutter/material.dart';
import 'package:learning_english/noglow_behaviour.dart';
import 'package:learning_english/screens/vocabulary_detail.dart';

class TopicVocabularies extends StatelessWidget {
  const TopicVocabularies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C7352),
        title: const Text("Lesson: COLOR"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: ListView(
          children: [
            ListBody(children: <Widget>[
              Card(
                child: ListTile(
                  title: const Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VocabularyDetail())),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('red'),
                  subtitle: Text('Màu đỏ'),
                  onTap: () => {
                    print("đi tới trang từ vựng chi tiết"),
                  },
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: const ListTile(
                  title: Text('brown'),
                  subtitle: Text('Màu nâu'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
