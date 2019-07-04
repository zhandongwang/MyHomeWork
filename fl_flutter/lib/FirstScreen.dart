import 'package:fl_flutter/SecondScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Launch new screen'),
          onPressed: (){
            Navigator.of(context).pushNamed('/Second');
            // Navigator.push(
            //   context, 
            //   new MaterialPageRoute(builder: (context) => new SecondScreen())
            //   );
          },
        ),
      ),
    );
  }
}