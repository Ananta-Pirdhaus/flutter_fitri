import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'lib/app/assets/images/flipcard2/bajuadat.png',
    'lib/app/assets/images/flipcard2/bajuadat.png',
    'lib/app/assets/images/flipcard2/barong.png',
    'lib/app/assets/images/flipcard2/barong.png',
    'lib/app/assets/images/flipcard2/reog.png',
    'lib/app/assets/images/flipcard2/reog.png',
    'lib/app/assets/images/flipcard2/rumahaceh.png',
    'lib/app/assets/images/flipcard2/rumahaceh.png',
    'lib/app/assets/images/flipcard2/rumahjogja.png',
    'lib/app/assets/images/flipcard2/rumahjogja.png',
    'lib/app/assets/images/flipcard2/rumahpadang.png',
    'lib/app/assets/images/flipcard2/rumahpadang.png',
    'lib/app/assets/images/flipcard2/rumahriau.png',
    'lib/app/assets/images/flipcard2/rumahriau.png',
    'lib/app/assets/images/flipcard2/rumahtoraja.png',
    'lib/app/assets/images/flipcard2/rumahtoraja.png',
    'lib/app/assets/images/flipcard2/wayang.png',
    'lib/app/assets/images/flipcard2/wayang.png',
  ];
}

List<String> getSourceArray(Level level) {
  List<String> levelAndKindList = <String>[];
  List<String> sourceArray = fillSourceArray();
  if (level == Level.Hard) {
    levelAndKindList.addAll(sourceArray);
  } else if (level == Level.Medium) {
    levelAndKindList.addAll(sourceArray.take(12));
  } else if (level == Level.Easy) {
    levelAndKindList.addAll(sourceArray.take(6));
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  return List<bool>.filled(
      level == Level.Hard ? 18 : (level == Level.Medium ? 12 : 6), true);
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  return List<GlobalKey<FlipCardState>>.generate(
    level == Level.Hard ? 18 : (level == Level.Medium ? 12 : 6),
    (index) => GlobalKey<FlipCardState>(),
  );
}
