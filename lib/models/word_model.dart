

class word_model{
   String word;
   int id;

  word_model({this.id,this.word});

//  String get Word => word;
  factory word_model.fromDatabaseJson(Map<String, dynamic> data) => word_model(
    word: data['word'],
    id: data['id']
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id" : this.id,
    "word" : this.word,
  };
}