import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoListProvider = ChangeNotifierProvider.autoDispose<MemoListController>(
  (ref) => MemoListController(),
);

class MemoListController extends ChangeNotifier {
  MemoListController() {
    /// 初期化処理をここに書く
    xPos = 0;
    yPos = 0;
  }
  @override
  void dispose() {
    super.dispose();
  }

  double xPos;
  double yPos;
}
