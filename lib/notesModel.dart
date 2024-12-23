import 'package:default_note_add_db/appdatabase.dart';

class NotesModel{

  int? note_id;
  String title;
  String desc;

  NotesModel({ this.note_id,required this.title,required this.desc });


  factory NotesModel.fromMap(Map<String,dynamic> map){
    return NotesModel(
        note_id:map[AppDataBase.NOTES_COLUMN_ID],
        title: map[AppDataBase.NOTES_COLUMN_TITLE],
        desc: map[AppDataBase.NOTES_COLUMN_DESC]
    );
  }

  Map<String,dynamic> toMap(){
    return{
      AppDataBase.NOTES_COLUMN_ID:note_id,
      AppDataBase.NOTES_COLUMN_TITLE:title,
      AppDataBase.NOTES_COLUMN_DESC:desc
    };
  }


}