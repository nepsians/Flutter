import 'package:flutter_app/model/ablum.dart';

class AppState {
  double sliderFontSize;
  bool bold;
  bool italic;
  List<User> user;

  AppState(
      {this.sliderFontSize = 0.5,
      this.bold = false,
      this.italic = false,
      this.user});

  AppState.fromAppState(AppState another) {
    sliderFontSize = another.sliderFontSize;
    bold = another.bold;
    italic = another.italic;
    user = another.user;
  }

  double get viewFontSize => sliderFontSize * 30;
}
