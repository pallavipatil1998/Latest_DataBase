import 'package:default_note_add_db/appdatabase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  late AppDataBase myDb;
  List<Map<String,dynamic>> arrNotes=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDb=AppDataBase.db;
    showAllNotes();

  }

  void showAllNotes()async{
    arrNotes=await  myDb.fetchAllNotes();
    setState(() {

    });
  }
  void insertNote()async{
    bool check= await myDb.addNote("Flutter", "The best course");
    if(check){
      arrNotes=await myDb.fetchAllNotes();
      setState(() {
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DataBase"),) ,
      body: ListView.builder(
        itemCount: arrNotes.length,
          itemBuilder: (_ ,index){
          return ListTile(
            title:Text(arrNotes[index]["title"]),
            subtitle: Text("${arrNotes[index]["desc"]}"),
          );

          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          insertNote();
        },
      backgroundColor: Colors.blue,
      child: Icon(Icons.add,color: Colors.white,),
    ),
      );
  }
}
