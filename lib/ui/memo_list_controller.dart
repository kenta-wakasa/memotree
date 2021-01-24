import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotree/data/memo_entity.dart';

final memoListProvider = ChangeNotifierProvider.autoDispose<MemoListController>(
  (ref) => MemoListController(),
);

class MemoListController extends ChangeNotifier {
  MemoListController() {
    /// 初期化処理をここに書く
    memoEntities = [
      MemoEntity(pos: const Offset(100, 50), color: Colors.grey),
      MemoEntity(pos: const Offset(30, 200), color: Colors.grey),
      MemoEntity(pos: const Offset(200, 400), color: Colors.grey),
    ];
    generateMemos();
    tapPosition = const Offset(0, 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Offset tapPosition;
  List<MemoEntity> memoEntities = [];
  List<Widget> memos = [];
  int slectedHash;

  void generateMemos() {
    final _memos = <Widget>[];
    for (final memoEntity in memoEntities) {
      _memos.add(movableBox(memoEntity));
    }
    _memos.add(
      GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onPanUpdate: (details) {
          tapPosition = details.localPosition;
          changePos(tapPosition);
          generateMemos();
        },
      ),
    );
    memos = _memos;
    notifyListeners();
  }

  Widget movableBox(MemoEntity memoEntity) {
    return Positioned(
      left: memoEntity.pos.dx,
      top: memoEntity.pos.dy,
      child: Container(
        height: 100,
        width: 100,
        color: memoEntity.color,
        child: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTapDown: (details) {
            slectedHash = memoEntity.hashCode;
            changeColor(slectedHash);
            generateMemos();
          },
        ),
      ),
    );
  }

  void changeColor(int hashCode) {
    for (final memoEntity in memoEntities) {
      if (memoEntity.hashCode == hashCode) {
        memoEntity.color = Colors.yellow;
      } else {
        memoEntity.color = Colors.grey;
      }
    }
  }

  void changePos(Offset pos) {
    for (final memoEntity in memoEntities) {
      if (memoEntity.hashCode == slectedHash) {
        memoEntity.pos = pos;
      }
    }
  }
}
