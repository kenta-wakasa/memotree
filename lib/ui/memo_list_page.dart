import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'memo_list_controller.dart';

class MemoListPage extends ConsumerWidget {
  const MemoListPage({Key key}) : super(key: key);

  /// どのインスタンスであっても不変な値を static として宣言する
  static const String title = 'メモ一覧';
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _provider = watch(memoListProvider);
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,
      onPanUpdate: (details) {
        _provider.xPos = details.localPosition.dx;
        // ignore: cascade_invocations
        _provider.yPos = details.localPosition.dy;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
