class Vocabulary {
  final String word;
  final String meaning;
  final String imagePath;

  const Vocabulary(
      {required this.word,
      required this.meaning,
      required this.imagePath});

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      word: json['word'],
      meaning: json['hasMeaning'],
      imagePath: json['hasImage'],
    );
  }
}
