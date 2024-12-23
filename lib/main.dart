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
  var titleController=TextEditingController();
  var descController=TextEditingController();
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
  void insertNote(String title,String desc)async{
    bool check= await myDb.addNote(title,desc);
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
          showModalBottomSheet(
              context: context,
              builder: (context){
                return Container(
                  height: 400,
                  child: Column(
                    children: [
                      Text("ADD NOTE"),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text("Title"),
                          hintText: "Enter Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                          label: Text("Desc"),
                          hintText: "Enter Desc",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (){
                            var mtitle=titleController.text.toString();
                            var mdesc= descController.text.toString();
                            insertNote(mtitle,mdesc);
                            showAllNotes();
                            titleController.clear();
                            descController.text="";
                            Navigator.pop(context);

                          },
                          child: Text("Add Note")
                      )
                    ],
                  ),

                );
              }
          );
        },
      backgroundColor: Colors.blue,
      child: Icon(Icons.add,color: Colors.white,),
    ),
      );
  }
}
