import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'memo_list_controller.dart';

class MemoListPage extends ConsumerWidget {
  MemoListPage({Key key}) : super(key: key);
  static const String title = 'メモ一覧';
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _provider = watch(memoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'x: ${_provider.tapPosition.dx.toStringAsFixed(1).padLeft(5, '0')} '
          'y: ${_provider.tapPosition.dy.toStringAsFixed(1).padLeft(5, '0')}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ),
      body: Stack(
        children: _provider.memos,
      ),
    );
  }
}
