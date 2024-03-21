import 'package:api_dictionary/models/data.dart';
import 'package:api_dictionary/models/word.dart';

abstract class DictionaryRepository{
  Future<Data<Word>> getWord({required String searchWord});
}