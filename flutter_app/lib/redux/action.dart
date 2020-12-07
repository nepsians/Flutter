import 'package:flutter_app/model/ablum.dart';

class FontSize {
  final double payload;
  FontSize(this.payload);
}

class Bold {
  final bool payload;
  Bold(this.payload);
}

class Italic {
  final bool payload;
  Italic(this.payload);
}

class UserAction {
  final List<User> payload;
  UserAction(this.payload);
}
