import 'package:api_dictionary/commons/app_paths.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/repository/dictionary_repository.dart';
import 'package:dio/dio.dart';

class DictionaryRepositoryImpl extends DictionaryRepository{
  final Dio dio;
  DictionaryRepositoryImpl({required this.dio});

  @override
  Future<Word> getWord({required String searchWord}) async {
    final Response<List<dynamic>> response = await dio.get('${AppPaths.endPoint}/$searchWord');
    if(response.statusCode == 200){
      return Word.fromJson(response.data!.first);
    }else{
      return Word();
    }
  }

}