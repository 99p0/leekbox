import 'dart:math';

class LoLWords {
  final String word;
  final String wordEnglish;

  LoLWords(this.word, this.wordEnglish);
}

class LoLWordsFactory {
  static List<LoLWords> words = [
    LoLWords('哼，一个能打的都没有。', ''),
    LoLWords('若无闲事挂心头，便是人间好时节...', ''),
    LoLWords('我总感觉你在牛A与牛C之间徘徊。', ''),
    LoLWords('当裤子失去皮带，才懂得什麽叫做依赖。', ''),
    LoLWords('当男人遇见女人，从此只有纪念日，没有独立日。', ''),
    LoLWords('春有百花秋有月，夏有凉风冬有雪', ''),
    // LoLWords('有钱的捧个钱场，没钱的回家取点钱来捧个钱场。', ''),
    // LoLWords('有时候 有时候 可那只是有时候。', ''),
    // LoLWords('犹叹当年小蛮腰，看今朝，空余恨，一身五花膘。', ''),
    LoLWords('玩了一辈子鹰，不能让鹰啄了眼！', ''),
    LoLWords('纵有千古，横有八荒。 前途似海，来日方长。', ''),
    LoLWords('执着于理想，纯粹于当下。', ''),
    LoLWords('一往情深深几许？深山夕照深秋雨。', ''),
    LoLWords('偷得浮生半日闲...', ''),
    LoLWords('娶一个有趣的老婆，人生也会有趣的多。', ''),
    LoLWords('如果你丢了一只鸡，会怎么样？', ''),
    LoLWords('因为坚持，所以不怕遗憾。', ''),
    LoLWords('携带清风，踏上征程。', ''),
    LoLWords('一个人快活，两个人生活，三个人就是你死我活。', ''),
  ];

  static LoLWords randomWord() {
    return words[Random().nextInt(words.length)];
  }
}
