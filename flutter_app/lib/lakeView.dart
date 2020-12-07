import "package:flutter/material.dart";
import 'package:flutter_app/model/app_state.dart';
import 'drawer_menu.dart';

import "package:flutter_redux/flutter_redux.dart";
import 'package:flutter_app/redux/action.dart';

class LakeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          )
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(color, Icons.call, "CALL"),
          _buildButtonColumn(color, Icons.near_me, "ROUTE"),
          _buildButtonColumn(color, Icons.share, "SHARE"),
        ],
      ),
    );

    Widget textSection(bold, italic) {
      return Container(
        padding: const EdgeInsets.all(18),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
          style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontStyle: italic ? FontStyle.italic : FontStyle.normal),
        ),
      );
    }

    return MaterialApp(
      title: "Sbout",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Detail Layout"),
          ),
          drawer: DrawerMenu(),
          body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return ListView(
                children: <Widget>[
                  Image.asset("images/lake.jpg",
                      width: 600, height: 240, fit: BoxFit.cover),
                  titleSection,
                  buttonSection,
                  textSection(state.bold, state.italic),
                  textSection(state.bold, state.italic)
                ],
              );
            },
          )),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }
}
