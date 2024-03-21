import 'package:api_dictionary/models/data.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:equatable/equatable.dart';

abstract class WordState extends Equatable{
  @override
  List<Object?> get props => [];
}

class WordInitState extends WordState{}

class WordLoadingState extends WordState{}

class WordSuccessState extends WordState{
  final Success<Word> data;
  WordSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class WordFailureState extends WordState{
  final Failure<Word> failure;
  WordFailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class WordAfterFilerState extends WordState{
  final Word word;
  WordAfterFilerState({required this.word});

  @override
  List<Object?> get props => [word];
}