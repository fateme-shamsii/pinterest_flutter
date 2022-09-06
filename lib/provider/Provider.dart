
import 'package:flutter/material.dart';
import 'package:pintreset_flutter_samin/page/homeScreen.dart';
import 'package:provider/provider.dart';

class hideShow with ChangeNotifier {
  void nextPage( dynamic context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        notifyListeners();
  }
}
