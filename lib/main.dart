import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page', myChild: MyCenterWidget()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Widget myChild;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  MyHomePage({Key key, this.myChild, this.title}) : super(key: key);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('MyHomePage Build...');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MyInheritedWidget(
        myData: _counter,
        child: widget.myChild,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('MyCenter Build...');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyTextWidget(),
        ],
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int _counter = MyInheritedWidget.of(context).myData;
    log('MyText Build...$_counter');
    return Text('Tui là widget Text. Data của tui hiện tại là: $_counter');
  }
}

class MyInheritedWidget extends InheritedWidget {
  // 1
  MyInheritedWidget({Widget child, this.myData}) : super(child: child);

  // 2
  final int myData;

  // 3
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    // return myData %2 == 1; kiểm tra sự thay đổi của data để quyết định rebuild hay không
    return myData != oldWidget.myData;
  }

  // 4
  static MyInheritedWidget of(BuildContext context) {
    // 5
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
