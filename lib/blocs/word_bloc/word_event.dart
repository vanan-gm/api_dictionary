import 'package:api_dictionary/models/word.dart';
import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetWordDefinitionEvent extends WordEvent{
  final String word;
  GetWordDefinitionEvent({required this.word});

  @override
  List<Object?> get props => [word];
}

class ResetSearchWordEvent extends WordEvent{}

class FilterWordTypeEvent extends WordEvent{
  final Word word;
  final String filterType;
  FilterWordTypeEvent({required this.word, required this.filterType});

  @override
  List<Object?> get props => [word, filterType];
}