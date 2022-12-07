import 'dart:math';

class LoLWords {
  final String word;
  final String wordEnglish;

  LoLWords(this.word, this.wordEnglish);
}

class LoLWordsFactory {
  static List<LoLWords> words = [
    LoLWords('窈窕淑女，君子好个球⚽️。', 'Follow the wind, but watch your back.'),
    LoLWords('我总感觉你在牛A与牛C之间徘徊。', 'Follow the wind, but watch your back.'),
    LoLWords('当裤子失去皮带，才懂得什麽叫做依赖。', 'Follow the wind, but watch your back.'),
    LoLWords('当男人遇见女人，从此只有纪念日，没有独立日。', 'Follow the wind, but watch your back.'),
    LoLWords('只想优雅转身，不料华丽撞墙!', 'Follow the wind, but watch your back.'),
    LoLWords('有钱的捧个钱场，没钱的回家取点钱来捧个钱场。', 'Follow the wind, but watch your back.'),
    LoLWords('有时候 有时候 可那只是有时候。', 'Follow the wind, but watch your back.'),
    LoLWords('哼，一个能打的都没有。', 'Who wants a piece of the champ?'),
    LoLWords('犹叹当年小蛮腰，看今朝，空余恨，一身五花膘。', 'Who wants a piece of the champ?'),
    LoLWords('纵有千古，横有八荒。 前途似海，来日方长。', 'Who wants a piece of the champ?'),
    LoLWords('执着于理想，纯粹于当下。', 'Who wants a piece of the champ?'),
    LoLWords('一往情深深几许？深山夕照深秋雨。', 'Who wants a piece of the champ?'),
    LoLWords('行路难，不在水，不在山，只在人情反覆间。', 'Who wants a piece of the champ?'),
    LoLWords('把一块泥，捻一个尔，塑一个我', 'Who wants a piece of the champ?'),
    LoLWords('娶一个有趣的老婆，人生也会有趣的多。', 'Who wants a piece of the champ?'),
    LoLWords('如果你丢了一只鸡，会怎么样？', 'Who wants a piece of the champ?'),
    LoLWords('因为坚持，所以不怕遗憾。', 'Who wants a piece of the champ?'),
    LoLWords('携带清风，踏上征程。', 'Who wants a piece of the champ?'),
    LoLWords('在北方，有一种运动叫滚犊子。', 'Who wants a piece of the champ?'),
    LoLWords('一个人快活，两个人生活，三个人就是你死我活。', 'Who wants a piece of the champ?'),
  ];

  static LoLWords randomWord() {
    return words[Random().nextInt(words.length)];
  }
}
