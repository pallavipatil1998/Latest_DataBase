import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  //singlton private constructor
  AppDataBase._();

  static final AppDataBase db= AppDataBase._();

  Database? _database;


  Future<Database> getDb()async{

    if(_database!= null){
      return _database!;
    }else{
      return await initDb();
    }

  }


 Future<Database>initDb() async{
    Directory documentDirectory= await getApplicationDocumentsDirectory();
    var dbPath= join(documentDirectory.path,"noteDb.db");

    return openDatabase(
        dbPath,
      version: 1,
      onCreate: (db,dbPath){
          db.execute("create table note(note_id integer primary key autoincrement, title text, desc text)");

      }
    );
  }

  Future<bool>addNote(String title, String desc) async{
    var d1= await getDb();
    int rowsEffect = await d1.insert("note",{"title":title , "desc":desc});

    if(rowsEffect>0){
      return true;
    }else{
      return false;
    }
  }


 Future<List<Map<String,dynamic>>> fetchAllNotes()async{
    var d2=await getDb();
     List<Map<String,dynamic>> notes =await d2.query("note");
     return notes;
  }

}