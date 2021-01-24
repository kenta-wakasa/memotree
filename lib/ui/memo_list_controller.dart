import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entity/memo_entity.dart';

final memoListProvider = ChangeNotifierProvider.autoDispose<MemoListController>(
  (ref) => MemoListController(),
);

class MemoListController extends ChangeNotifier {
  MemoListController() {
    memoEntities = [
      MemoEntity(pos: const Offset(100, 50), color: Colors.grey),
      MemoEntity(pos: const Offset(30, 200), color: Colors.grey),
      MemoEntity(pos: const Offset(200, 400), color: Colors.grey),
    ];
    tapPosition = const Offset(0, 0);
  }

  Offset tapPosition;
  List<MemoEntity> memoEntities = <MemoEntity>[];
  int slectedHash;

  List<Widget> get memos {
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
          notifyListeners();
        },
      ),
    );
    return _memos;
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
            changeColor(memoEntity);
            notifyListeners();
          },
        ),
      ),
    );
  }

  void changeColor(MemoEntity memoEntity) {
    for (final _memoEntity in memoEntities) {
      if (_memoEntity == memoEntity) {
        _memoEntity.color = Colors.yellow;
      } else {
        _memoEntity.color = Colors.grey;
      }
    }
  }

  void changePos(Offset pos) {
    if (slectedHash != null) {
      memoEntities.firstWhere((e) => e.hashCode == slectedHash).pos = pos;
    }
  }
}
