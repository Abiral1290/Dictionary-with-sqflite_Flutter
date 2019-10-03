import 'dart:async';
import 'package:eighteen_app/models/word_model.dart';
import 'package:eighteen_app/repository/word_repository.dart';
import 'dart:core';

class word_bloc{

  final _wordrepository = word_repository();

  final _sumitrepository = StreamController<bool>.broadcast();


  final _wordcontroller = StreamController<List<word_model>>.broadcast();

  Stream<List<word_model>> get words => _wordcontroller.stream;
  Stream<bool> get sub => _sumitrepository.stream;

  Function get wor => _wordcontroller.sink.add;

  Function get subb => _sumitrepository.sink
      .add;

  getwords({String query}) async{
    await _wordrepository.getword(query : query).then(wor);
  }

  add(word_model word) async{
    await _wordrepository.insert(word).then((value){
      _sumitrepository.sink.add;
    });
  }
}
