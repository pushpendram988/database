import 'package:database_init/app_database.dart';
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
      home:  HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String , dynamic>> allNotes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
    setState(() {

    });

  }

 void getAllNotes() async{
    allNotes  = await appDataBase.db.fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
appDataBase db = appDataBase.db;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: allNotes.isNotEmpty ? ListView.builder(itemBuilder: (_ , index){
        return ListTile(
          title: Text(allNotes[index][appDataBase.Column_Note_title]),
          subtitle: Text(allNotes[index][appDataBase.Column_Note_Desc]),
        );
      },

      ) : Center(child: Text("no database yet"),),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

        bool check = await  db.insertNote(title: "Notes", desc: " do whatever you want , just chill!!!");
        if(check) {
          getAllNotes();
        }
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
