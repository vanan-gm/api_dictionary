class Word {
  final String word;
  final String phonetic;
  final List<Phonetics> phonetics;
  final List<Meanings> meanings;

  Word(
      {this.word = '',
        this.phonetic = '',
        this.phonetics = const [],
        this.meanings = const []
      });

  factory Word.fromJson(Map<String, dynamic> json) {
    List<Phonetics> phonetics = [];
    List<Meanings> meanings = [];
    if(json['phonetics'] != null){
      for(var item in json['phonetics']){
        phonetics.add(Phonetics.fromJson(item));
      }
    }
    if(json['meanings'] != null){
      for(var item in json['meanings']){
        meanings.add(Meanings.fromJson(item));
      }
    }
    return Word(
      word: json['word'] ?? '',
      phonetic: json['phonetic'] ?? '',
      phonetics: phonetics,
      meanings: meanings,
    );
  }
}

class Phonetics {
  final String text;
  final String audio;

  Phonetics({this.text = '', this.audio = ''});

  factory Phonetics.fromJson(Map<String, dynamic> json) {
    return Phonetics(
      audio: json['audio'] ?? '',
      text: json['text'] ?? '',
    );
  }
}

class Meanings {
  final String partOfSpeech;
  final List<Definitions> definitions;
  final List<String> synonyms;
  final List<String> antonyms;

  Meanings({this.partOfSpeech = '', this.definitions = const [], this.synonyms = const [], this.antonyms = const []});

  factory Meanings.fromJson(Map<String, dynamic> json) {
    List<Definitions> definitions = [];
    List<String> synonyms = [];
    List<String> antonyms = [];
    if(json['definitions'] != null){
      for(var item in json['definitions']){
        definitions.add(Definitions.fromJson(item));
      }
    }
    if(json['synonyms'] != null){
      for(var item in json['synonyms']){
        synonyms.add(item as String);
      }
    }
    if(json['antonyms'] != null){
      for(var item in json['antonyms']){
        antonyms.add(item as String);
      }
    }
    return Meanings(
      partOfSpeech: json['partOfSpeech'] ?? '',
      definitions: definitions,
      antonyms: antonyms,
      synonyms: synonyms,
    );
  }
}

class Definitions {
  String definition;
  String example;

  Definitions({this.definition = '', this.example = ''});

  factory Definitions.fromJson(Map<String, dynamic> json) {
    return Definitions(
      definition: json['definition'] ?? '',
      example: json['example'] ?? '',
    );
  }
}