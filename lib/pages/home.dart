import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userToDo = '';
  List<String> todoList = [];

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFireBase();

    todoList.addAll(['Learn Dart', 'Learn Flutter', 'Rock mobile development 🤘']);
  }

  void _menuOpen(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context){
          return Scaffold(
              appBar: AppBar(
                title: Text('Menu'),
              ),
              body: Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  }, child: Text('Main'))
                ],
              )
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('ToDo List'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _menuOpen, icon: Icon(Icons.menu_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Text('No records');
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data?.docs[index].get('item')),
                      trailing: IconButton(
                          onPressed: (){
                            // setState(() {
                            //   todoList.removeAt(index);
                            // });
                            FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.deepOrangeAccent
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    // if(direction == DismissDirection.endToStart){}
                    setState(() {
                      todoList.removeAt(index);
                    });
                  },
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Add new ToDo item'),
                  content: TextField(
                    onChanged: (String value){
                      userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(onPressed: (){
                      if(userToDo.length > 0){
                        // setState(() {
                        //   todoList.add(userToDo);
                        //   userToDo='';
                        // });
                        FirebaseFirestore.instance.collection('items').add({
                          'item': userToDo
                        });
                      }
                      Navigator.of(context).pop();
                    }, child: Text('Add'))
                  ],
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
