import 'package:fl_flutter/HomePage.dart';
import 'package:fl_flutter/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget titleSection() {
    return new Container(
        color: Colors.yellowAccent,
        padding: const EdgeInsets.all(32.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: new Text(
                      'Oeschinen Lake Campground',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    'Kandersteg, Switzerland',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            new FavoriteWidget(),



          ],
        ),
      );
  }

    Container _buildBottonColumn(Color color, IconData icon, String label) {
      return new Container(
        color: Colors.red,
        child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(icon,color:color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style:new TextStyle (
                color: color,fontSize: 12.0,
                fontWeight: FontWeight.w400
                )
            ),
          )
        ],
      ),
      );
    } 
     Widget buttonSection(BuildContext context) {
       Color color = Theme.of(context).primaryColor;
       return new Container(
        color: Colors.yellow,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBottonColumn(color,Icons.call, 'CALL'),
            _buildBottonColumn(color,Icons.near_me, 'ROUTE'),
            _buildBottonColumn(color,Icons.share, 'SHARE'),
          ],
        ),
      );
    } 

    Widget textSection(){
        return new Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
          '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
          softWrap:true,
        ),
        );
    } 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Flutter layout'),
        ),
        body: new ListView(
          children:[
            Image.asset('images/lake.jpeg',height: 240,fit: BoxFit.cover),
            titleSection(),
            buttonSection(context),
            textSection(),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() {
    // TODO: implement createState
    return new _FavoriteWidgetState();
  }
  
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  
  void _toggleFavorite(){
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
      } else 
      {
        _favoriteCount += 1;
      }
       _isFavorited = !_isFavorited;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(0),
          child: new IconButton(
            color: Colors.red[500],
            icon: _isFavorited ? new Icon(Icons.star) : new Icon(Icons.star_border),
            onPressed: _toggleFavorite,
          ),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
            child: new Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }


}


class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(child: new Container(
      height: 56,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(
         borderRadius: new BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
      ),
    ),
    onTap: (){
      print('MyButton was tapped');
    },);
  }
}


class MyAppBar extends StatelessWidget {
  final Widget title;
  MyAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const  EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: new BoxDecoration(color:Colors.red),
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          new Expanded(
            child: new Center(
              child: title,
            ) ,
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
    );
  }
}


class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Example title',
            ),
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello flutter'),
            ),
          )
          
        ],
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
