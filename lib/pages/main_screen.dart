import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('ToDo List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Main Screen', style: TextStyle(color: Colors.white)),
          ElevatedButton(onPressed: (){
            // with back button
            Navigator.pushNamed(context, '/list');
            // true - show back arrow, false hide it
            // Navigator.pushNamedAndRemoveUntil(context, '/list', (route) => false);
            Navigator.pushReplacementNamed(context, '/list');
          }, child: Text('Next'))
        ],
      ),
    );
  }
}
