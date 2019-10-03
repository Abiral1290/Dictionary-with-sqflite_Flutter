import 'package:flutter/material.dart';
import 'package:eighteen_app/bloc/bloc_words.dart';
import 'package:eighteen_app/models/word_model.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final word_bloc _bloc = word_bloc();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title:,
      ),
      body: new SafeArea(
        child: Container(
          color: Colors.white60,
          padding: const EdgeInsets.only(left: 2.0, right: 20, bottom: 2.0),
          child: Container(
            child: getword(),
          ),
        ),
      ),
        bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(topRight: const Radius.circular(2.0), topLeft: const Radius.circular(2.0))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed:(){
//              calling to list again
              _bloc.getwords();
            }),
            Expanded(
              child: Text("Words",
              style: TextStyle(
                color: Colors.limeAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Wrap(children: <Widget>[
              IconButton(icon: Icon(Icons.search),
                  onPressed: (){
                searchWidget(context);
                  })
            ],)
          ],
        ),
      ),
    ),
    );
  }



  void searchWidget(BuildContext context){
    final _textcontroller = TextEditingController();

    showModalBottomSheet(context: context,
        builder:(builder){
      return Padding(padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.blueGrey,
        child: Container(
          height: 200,
          decoration:  new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(topLeft: const Radius.circular(10.0),topRight: const Radius.circular(10.0)),
          ),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        controller:  _textcontroller,
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                        autofocus: true,
                        validator: (String value){
                         if(value.isEmpty){
                           return "No Words";
                         }else return value.contains('') ? "Capital not included" : null;
                        },
                      )),
                  Padding(padding: EdgeInsets.only(left: 10, top: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.limeAccent,
                    radius: 20,
                    child: IconButton(icon: Icon(Icons.add),
                        onPressed: (){
                      final newwords = word_model(word: _textcontroller.value.text);
                      if(newwords.word.isNotEmpty){
                        _bloc.add(newwords);

                        Navigator.pop(context);
                      }
                        }),
                  ),)
                ],
              )
            ],
          ),
        ),
      ),
      );
        });
  }

  Widget getword(){

    return StreamBuilder(stream: _bloc.getwords(),
        builder: (BuildContext context, AsyncSnapshot<List<word_model>> snapshot) {
          return snapshot.data.length != 0
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, item) {
                word_model word = snapshot.data[item];
                {
                  final Widget dissmis = new Dismissible(
                    key: new ObjectKey(word),
                    child: Card(shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[200], width: 0.5),),
                      color: Colors.white,
                      child: ListTile(
                        leading: InkWell(
                          onTap: () {},
                        ),
                      ),),
                  );
                  return dissmis;
                }
              })
        } );
  }
//  Widget Words(){
//    return StreamBuilder(stream: _bloc.add(),
//        builder: ())
//  }

  Widget Widgetlist(){
    return StreamBuilder(builder: (BuildContext context, AsyncSnapshot<List<word_model>> snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data.length,
            itemBuilder: (context, item){
            word_model word = snapshot.data[item];{
              final Widget dissmis = new Dismissible(key: new ObjectKey(word),
                child: Card(shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[200], width: 0.5),),
                color: Colors.white,
                child: ListTile(
                  leading: InkWell(
                    onTap: (){
                    },
                  ),
                ),),
              );
              return dissmis;
            }
            }
        );
      }else{
        return Text("No Words Enlisted");
      }
    });
  }
//  Widget addwidget() async{
//    return StreamBuilder(builder: (BuildContext context, AsyncSnapshot))
//  }


}
