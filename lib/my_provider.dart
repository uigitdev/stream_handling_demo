import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uigitdev_stream_holder/uigitdev_stream_holder.dart';

class MyProvider extends ChangeNotifier {
  final numberStream = StreamController<int>.broadcast();

  void addNumber(int number) => numberStream.add(number);

  //------------------

  final numberStreamHolder = StreamHolder<int?>(null);

  void initData() async {
    await Future.delayed(const Duration(seconds: 4));
    numberStreamHolder.addData(Random().nextInt(40));
  }
}
