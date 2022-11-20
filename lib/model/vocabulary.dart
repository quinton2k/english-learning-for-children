class Vocabulary {
  final String word;
  final String meaning;
  // final String imagePath;
  final String topicName;

  const Vocabulary({
    required this.word,
    required this.meaning,
    // required this.imagePath
    required this.topicName,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      word: json['word'],
      meaning: json['hasMeaning'],
      topicName: json['topicName'],
      // imagePath: json['hasImage'],
    );
  }
}
