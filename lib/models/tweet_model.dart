import 'package:db_test_app/utils/extension_methods.dart';

class TweetModel {
  final String title;
  final String subTitle;
  final List<String> emojis;

  const TweetModel({
    required this.title,
    required this.subTitle,
    required this.emojis,
  });

  factory TweetModel.fromDB(Map<String, dynamic> db) {
    return TweetModel(
      title: db['title'],
      subTitle: db['subtitle'],
      emojis: db['emoji'],
    );
  }

  TweetModel copyWith({
    String? title,
    String? subTitle,
    String? emojis,
  }) {
    return TweetModel(
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        emojis: this.emojis.editList(emojis));
  }

  Map<String, dynamic> mapToDB() => {
        "title": title,
        "subtitle": subTitle,
        "emoji": emojis,
      };
}
