import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget extends StatelessWidget {
  final Widget child;

  ProviderWidget({Key key, @required this.child}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: child,
    );
  }
}

class MainProvider with ChangeNotifier {
  Random _random = Random();

  Random get random => _random;
  set random(Random value) {
    _random = value;
    notifyListeners();
  }
}
