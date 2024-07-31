import 'dart:async';

import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {
  // Stream
  final StreamController<String> _stream = StreamController<String>.broadcast();

  // Getter
  Stream<String> get stream => _stream.stream;

  // Add a value to the stream
  void addValue(String value) {
    _stream.add(value);
  }

  // Dispose
  @override
  void dispose() {
    _stream.close();
    super.dispose();
  }
}
