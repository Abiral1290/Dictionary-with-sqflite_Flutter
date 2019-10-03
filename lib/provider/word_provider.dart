import 'dart:async';
import 'package:eighteen_app/Dbhelper/Db_helper.dart';
import 'package:eighteen_app/models/word_model.dart';


class word_provider{

  final dbprovider = Dbhelper.dhhelper;


  Future<int> createlist(word_model word) async{
    final db = await dbprovider.database;
    var result = db.insert(TABLE_NAME_1, word.toDatabaseJson());
    return result;
  }

  Future<List<word_model>> getWord({List<String> column, String Query}) async{
    final db = await dbprovider.database;

    List<Map<String, dynamic>> result;
    if(Query != null){
      result = await db.query(TABLE_NAME_1, columns: column, where: "Words Like ? ", whereArgs: ["%$Query%"]);
    }else{
      result = await db.query(TABLE_NAME_1, columns: column);
    }

    List<word_model> words = result.isNotEmpty ? result.map((item) => word_model.fromDatabaseJson(item)).toList() : [];
    return words;
  }
}