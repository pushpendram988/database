import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class appDataBase{
// Private Construction Singleton class Creation
  appDataBase._();
  static final String DB_Name = "notes.db";
  static final  String Table_Note_Name = "noted";
  static final String Column_note_id = 'n_id';
  static final  String Column_Note_title = 'n_title';
  static final   String Column_Note_Desc = 'n_desc';


  static final appDataBase db = appDataBase._();

  ///get-db
  ///
  Database?  mdb;
Future<Database> getDB() async{
  if(mdb!=null){
   return mdb!;
  }else{
 return await  openDB();
  }

}
//open db
Future<Database> openDB() async{
  var rootPath = await getApplicationDocumentsDirectory();
//data/dat/com.example.db/databases/notes.db;
  var dbpath = join(rootPath.path ,DB_Name);

  return await openDatabase(dbpath , version: 1 ,

      ///create db
      onCreate: (db , version){
// will be creating all the table for maintaining databases
  // create table
    ///run any sql query
    
    db.execute("create table name $Table_Note_Name ($Column_note_id integer primary key autoincrement , $Column_Note_title text , $Column_Note_Desc text,) ");
  });
}


Future<bool>insertNote({required String title , required String desc}) async{
var mainDB = await  getDB();

int rowEffect = await mainDB.insert(Table_Note_Name, {
  Column_Note_title : title,
  Column_Note_Desc : desc,
});
  return rowEffect>0;


}
  Future<List<Map<String , dynamic>>> fetchAllNotes() async{

  var mainDB = await getDB();
  List<Map<String, dynamic>> mNotes= [];
  try {
     mNotes = await mainDB.query(Table_Note_Name);
  } catch(e){
    print('error : ${e.toString()}');
  }
return mNotes;


  }
}