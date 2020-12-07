import 'package:flutter/material.dart';
import 'drawer_menu.dart';

import "package:flutter_redux/flutter_redux.dart";
import 'package:flutter_app/model/app_state.dart';
import 'package:flutter_app/redux/action.dart';

import 'package:flutter_app/view_model.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Settings'),
        ),
        drawer: DrawerMenu(),
        body: new StoreConnector<AppState, ViewModel>(
          converter: (store) => ViewModel.fromStore(store),
          builder: (context, viewModel) {
            print(viewModel);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Name: ${viewModel.user[0].name} Email: ${viewModel.user[0].email} Company: ${viewModel.user[0].company.name}',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline.fontSize),
                  ),
                ),
                Slider(
                    min: 0.5,
                    value: viewModel.viewFontSize,
                    onChanged: (newValue) {
                      viewModel.setFontSize(newValue);
                    }),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: viewModel.bold,
                        onChanged: (newVal) {
                          viewModel.setBold(newVal);
                        },
                      ),
                      Text(
                        'Bold',
                        style: getStyle(viewModel.bold, false),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          value: viewModel.italic,
                          onChanged: (newVal) {
                            viewModel.setItalic(newVal);
                          }),
                      Text(
                        'Italic',
                        style: getStyle(false, viewModel.italic),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  TextStyle getStyle([bool isBold = false, bool isItalic = false]) {
    return TextStyle(
      fontSize: 18,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }
}
