class DetailVocab {
  final String hasAEAudio;
  final String hasAEpronunciation;
  final String hasBEAudio;
  final String hasBEpronunciation;
  final String hasImage;
  final String hasMeaning;
  final String vocab;
  final List<String> suggestArr;

  DetailVocab(
      {required this.hasAEAudio,
      required this.hasAEpronunciation,
      required this.hasBEAudio,
      required this.hasBEpronunciation,
      required this.hasImage,
      required this.hasMeaning,
      required this.vocab,
      required this.suggestArr});

  factory DetailVocab.fromJson(Map<String, dynamic> json) {
    return DetailVocab(
      hasAEAudio: json['hasAEAudio'],
      hasAEpronunciation: json['hasAEpronunciation'],
      hasBEAudio: json['hasBEAudio'],
      hasBEpronunciation: json['hasBEpronunciation'],
      hasImage: json['hasImage'],
      hasMeaning: json['hasMeaning'],
      vocab: json['vocab'],
      suggestArr: json['suggestArr'].cast<String>(),
    );
  }
}
