import 'dart:math';

class LoLWords {
  final String word;
  final String wordEnglish;

  LoLWords(this.word, this.wordEnglish);
}

class LoLWordsFactory {
  static List<LoLWords> words = [
    LoLWords('哼，一个能打的都没有。', 'abc'),
    LoLWords('若无闲事挂心头，便是人间好时节...', 'abc'),
    LoLWords('我总感觉你在牛A与牛C之间徘徊。', 'abc'),
    LoLWords('当裤子失去皮带，才懂得什麽叫做依赖。', 'abc'),
    LoLWords('当男人遇见女人，从此只有纪念日，没有独立日。', 'abc'),
    LoLWords('春有百花秋有月，夏有凉风冬有雪', 'abc'),
    LoLWords('小宝宝才做选择，猛男当然是全都要', 'abc'),
    // LoLWords('有时候 有时候 可那只是有时候。', ''),
    LoLWords('王牌飞行员申请出战。', 'abc'),
    LoLWords('玩了一辈子鹰，不能让鹰啄了眼！', 'abc'),
    LoLWords('纵有千古，横有八荒。 前途似海，来日方长。', 'abc'),
    LoLWords('执着于理想，纯粹于当下。', 'abc'),
    LoLWords('一往情深深几许？深山夕照深秋雨。', 'abc'),
    LoLWords('偷得浮生半日闲...', ''),
    LoLWords('娶一个有趣的老婆，人生也会有趣的多。', 'abc'),
    LoLWords('如果你丢了一只鸡，会怎么样？', 'abc'),
    LoLWords('因为坚持，所以不怕遗憾。', 'abc'),
    LoLWords('携带清风，踏上征程。', 'abc'),
    LoLWords('一个人快活，两个人生活，三个人就是你死我活。', 'abc'),
  ];

  static LoLWords randomWord() {
    return words[Random().nextInt(words.length)];
  }
}
