import 'dart:io';

import 'package:default_note_add_db/notesModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  //singlton private constructor
  AppDataBase._();

  static final AppDataBase db= AppDataBase._();

  Database? _database;

  static final NOTES_TABLE="note";
  static final NOTES_COLUMN_ID="note_id";
  static final NOTES_COLUMN_TITLE="title";
  static final NOTES_COLUMN_DESC="desc";


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
      onCreate: (db,version){
          db.execute("create table $NOTES_TABLE($NOTES_COLUMN_ID integer primary key autoincrement, $NOTES_COLUMN_TITLE text, $NOTES_COLUMN_DESC text)");

      }
    );
  }

  Future<bool>addNote(NotesModel note) async{
    var d1= await getDb();
    int rowsEffect = await d1.insert(NOTES_TABLE,note.toMap());

    if(rowsEffect>0){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateNote(NotesModel note)async{
    var d3=await getDb();
    var updatesRows= await d3.update(NOTES_TABLE, note.toMap(),where: "$NOTES_COLUMN_ID=${note.note_id}");
    return updatesRows>0;
  }


  Future<bool> deleteNotes(int id)async{
    var d4=await getDb();
    var deletesRows= await d4.delete(NOTES_TABLE,where: "$NOTES_COLUMN_ID=?", whereArgs: ["$id"]);
    return deletesRows>0;
  }


 Future<List<NotesModel>> fetchAllNotes()async{
    var d2=await getDb();
     List<Map<String,dynamic>> notes =await d2.query(NOTES_TABLE);
     List<NotesModel> notesList=[];

     for(Map<String,dynamic> note in notes){
       NotesModel model= NotesModel.fromMap(note);
       notesList.add(model);
     }

     return notesList;
  }

}