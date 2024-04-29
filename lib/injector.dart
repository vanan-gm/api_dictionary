import 'package:api_dictionary/blocs/word_bloc/word_bloc.dart';
import 'package:api_dictionary/helper/dio_helper.dart';
import 'package:api_dictionary/repository/dictionary_repository.dart';
import 'package:api_dictionary/repository/dictionary_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:speech_to_text/speech_to_text.dart';

final getIt = GetIt.instance;

Future<void> setUpInjector() async{
  // Dio
  getIt.registerLazySingleton<Dio>(() => DioHelper().dio);

  // Repository
  getIt.registerLazySingleton<DictionaryRepository>(() => DictionaryRepositoryImpl(dio: getIt()));

  // Bloc
  getIt.registerFactory<WordBloc>(() => WordBloc(repository: getIt()));

  // Speech to Text
  getIt.registerLazySingleton<SpeechToText>(() => SpeechToText());
}