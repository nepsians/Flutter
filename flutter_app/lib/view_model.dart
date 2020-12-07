import 'package:flutter_app/redux/action.dart';
import 'package:redux/redux.dart';
import "package:flutter_app/model/app_state.dart";
import 'package:flutter_app/redux/action.dart';
import 'package:flutter_app/model/ablum.dart';

class ViewModel {
  final double viewFontSize;
  final bool bold;
  final bool italic;

  final Function setFontSize;
  final Function setBold;
  final Function setItalic;
  final double getFontSize;
  final List<User> user;

  ViewModel(
      {this.viewFontSize,
      this.setFontSize,
      this.bold,
      this.italic,
      this.setBold,
      this.setItalic,
      this.getFontSize,
      this.user}) {
    print("hello");
  }

  static ViewModel fromStore(Store<AppState> store) {
    print("store: ${store.state.sliderFontSize}");
    return ViewModel(
        viewFontSize: store.state.sliderFontSize,
        bold: store.state.bold,
        italic: store.state.italic,
        setFontSize: (value) => store.dispatch(FontSize(value)),
        setBold: (value) => store.dispatch(Bold(value)),
        setItalic: (value) => store.dispatch(Italic(value)),
        getFontSize: store.state.viewFontSize,
        user: store.state.user);
  }
}
