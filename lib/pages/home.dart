import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userToDo = '';
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();

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
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                      title: Text(todoList[index]),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            todoList.removeAt(index);
                          });
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
                        setState(() {
                          todoList.add(userToDo);
                          userToDo='';
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
