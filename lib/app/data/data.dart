import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'lib/app/assets/images/flipcard/borobudur.png',
    'lib/app/assets/images/flipcard/borobudur.png',
    'lib/app/assets/images/flipcard/candiCoklat.png',
    'lib/app/assets/images/flipcard/candiCoklat.png',
    'lib/app/assets/images/flipcard/candiEmas.png',
    'lib/app/assets/images/flipcard/candiEmas.png',
    'lib/app/assets/images/flipcard/candiSilver.png',
    'lib/app/assets/images/flipcard/candiSilver.png',
    'lib/app/assets/images/flipcard/monas.png',
    'lib/app/assets/images/flipcard/monas.png',
    'lib/app/assets/images/flipcard/tugujogja.png',
    'lib/app/assets/images/flipcard/tugujogja.png',
    'lib/app/assets/images/flipcard/jamgadang.png',
    'lib/app/assets/images/flipcard/jamgadang.png',
    'lib/app/assets/images/flipcard/gedungsate.png',
    'lib/app/assets/images/flipcard/gedungsate.png',
    'lib/app/assets/images/flipcard/majapahit.png',
    'lib/app/assets/images/flipcard/majapahit.png',
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
