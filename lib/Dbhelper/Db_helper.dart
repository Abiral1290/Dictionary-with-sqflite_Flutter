import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';


//Written by - Abiral Basnet
// Date- 2019/10/02

final TABLE_NAME_1 = "table_name" ;
class Dbhelper {

  static final Dbhelper dhhelper = Dbhelper();

  final TABLE_NAME_1 = "table_name" ;
  Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;
    else
      _database = await createDatabase();
  }

  createDatabase() async{
    Directory directory  = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "dictionary.db");
    var database = await openDatabase(path, version: 1, onCreate: intDB, onUpgrade: Upgrade);
    return database;
  }

  void intDB(Database database, int version) async{
    return database.execute("CREATE TABLE $TABLE_NAME_1 ("
        "id INTERGER PRIMARY KEY,"
        "words TEXT"
    );
  }
  void Upgrade(Database database, int oldversion, int newoldversion) async{
    if(newoldversion > oldversion){

    }
  }
}

class Upgrade {
}