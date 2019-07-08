import 'package:fl_flutter/Todo.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;
  DetailScreen({Key key, @required this.todo}): super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${todo.title}"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16),
        child: new Text('${todo.description}'),
      ),
    );
  }
  

}