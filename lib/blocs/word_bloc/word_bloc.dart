import 'dart:async';

import 'package:api_dictionary/blocs/word_bloc/word_event.dart';
import 'package:api_dictionary/blocs/word_bloc/word_state.dart';
import 'package:api_dictionary/models/data.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/repository/dictionary_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState>{
  final DictionaryRepository repository;

  WordBloc({required this.repository}) : super(WordInitState()){
    on<GetWordDefinitionEvent>(_onGetWordDefinitionEvent);
    on<ResetSearchWordEvent>((event, emit) => emit(WordInitState()));
    on<FilterWordTypeEvent>(_onFilterWordTypeEvent);
  }

  FutureOr<void> _onGetWordDefinitionEvent(GetWordDefinitionEvent event, Emitter<WordState> emit) async{
    emit(WordLoadingState());
    final data = await repository.getWord(searchWord: event.word);
    if(data is Success<Word>){
      emit(WordSuccessState(data: data));
    }else if(data is Failure<Word>){
      emit(WordFailureState(failure: data));
    }
  }

  FutureOr<void> _onFilterWordTypeEvent(FilterWordTypeEvent event, Emitter<WordState> emit) async{
    if(event.filterType.toLowerCase() == 'all'){
      emit(WordAfterFilerState(word: event.word));
    }else{
      final listData = event.word.meanings.where((item) => item.partOfSpeech.toLowerCase() == event.filterType.toLowerCase()).toList();
      emit(WordAfterFilerState(word: Word().copyWith(
        word: event.word.word,
        phonetic: event.word.phonetic,
        phonetics: event.word.phonetics,
        meanings: listData,
      )));
    }
  }
}