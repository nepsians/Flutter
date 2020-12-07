import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/redux/action.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/lakeView.dart';
import 'package:flutter_app/Settings.dart';
import 'drawer_menu.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_app/model/app_state.dart';
import "package:flutter_app/redux/reducer.dart";

import 'package:flutter_app/model/ablum.dart';

void main() {
  final _initialState = AppState();
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);

  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: "/",
        routes: {
          "/": (context) => MyHomePage(
              title: 'Flutter Demo Home Page', name: "Nihal Shrestha"),
          "/about": (context) => LakeView(),
          "/settings": (context) => Settings()
        },
        theme: ThemeData(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.name}) : super(key: key);

  final String title;
  final String name;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final wordPair = WordPair.random();
  Store store;

  Future<User> futureAlbum;

  var users = new List<User>();

  @override
  void initState() {
    super.initState();

    futureAlbum = fetchAlbum();
  }

  Future<User> fetchAlbum() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");
    //print(json.decode(response.body));
    //print("REsponse: ${json.decode(response.body)}");
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      users = list.map((album) => User.fromJson(album)).toList();
      store = StoreProvider.of<AppState>(context, listen: false);
      store.dispatch(UserAction(users));
      print(list);
      return User.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception("Failed to load album");
    }
  }

  String horseUrl = 'https://i.stack.imgur.com/Dw6f7.png';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DrawerMenu(),
      // body: _buildSuggestions(),
      body: Center(
          child: FutureBuilder<User>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(users[index].email),
                );
              },
            );

            // return Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(snapshot.data.title),
            //     Text(
            //       '$_counter',
            //       style: Theme.of(context).textTheme.display1,
            //     ),
            //     RaisedButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, "/about");
            //       },
            //       child: Text(
            //         "Decrease the value",
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     )
            //   ],
            // );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
