import 'dart:math';

class LoLWords {
  final String word;
  final String wordEnglish;

  LoLWords(this.word, this.wordEnglish);
}

class LoLWordsFactory {
  static List<LoLWords> words = [
    LoLWords('且随疾风前行，身后亦须留心。', 'Follow the wind, but watch your back.'),
    LoLWords('哼，一个能打的都没有。', 'Who wants a piece of the champ?'),
    LoLWords('纵有千古，横有八荒。 前途似海，来日方长。', 'Who wants a piece of the champ?'),
    LoLWords('执着于理想，纯粹于当下。', 'Who wants a piece of the champ?'),
    LoLWords('一往情深深几许？深山夕照深秋雨。', 'Who wants a piece of the champ?'),
    LoLWords('行路难，不在水，不在山，只在人情反覆间。', 'Who wants a piece of the champ?'),
    LoLWords('把一块泥，捻一个尔，塑一个我', 'Who wants a piece of the champ?'),
    LoLWords('娶一个有趣的老婆，人生也会有趣的多。', 'Who wants a piece of the champ?'),
    LoLWords('如果你丢了一只鸡，会怎么样？', 'Who wants a piece of the champ?'),
  ];

  static LoLWords randomWord() {
    return words[Random().nextInt(words.length)];
  }
}
