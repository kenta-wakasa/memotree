import 'package:flutter/material.dart';

class MemoEntity {
  MemoEntity({
    this.pos = const Offset(0, 0),
    this.color = Colors.grey,
  }) {}
  Offset pos;
  Color color;
}
