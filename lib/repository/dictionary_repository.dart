import 'package:api_dictionary/models/word.dart';

abstract class DictionaryRepository{
  Future<Word> getWord({required String searchWord});
}