import 'package:eighteen_app/provider/word_provider.dart';
import 'package:eighteen_app/models/word_model.dart';

class word_repository{
  final word = word_provider();

  Future insert(word_model words) => word.createlist(words);

  Future getword({String query}) => word.getWord(Query : query);
}