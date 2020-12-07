import 'package:flutter_app/model/app_state.dart';
import 'action.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is FontSize) {
    newState.sliderFontSize = action.payload;
  } else if (action is Bold) {
    newState.bold = action.payload;
  } else if (action is Italic) {
    newState.italic = action.payload;
  } else if (action is UserAction) {
    newState.user = action.payload;
  }

  return newState;
}
