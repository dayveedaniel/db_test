import 'package:db_test_app/models/tweet_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../utils/constants.dart';

class DataBaseHandler {
  static late Box _box;

  static Future initDataBase() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(HiveKeys.tweetBoxKey);
  }

  static List<TweetModel> getAllEntries() {
    return List<TweetModel>.from(_box.values.map(
      (map) => TweetModel.fromDB(Map<String, dynamic>.from(map)),
    ));
  }

  static TweetModel getSingleTweet(int index) {
    return TweetModel.fromDB(Map<String, dynamic>.from(_box.getAt(index)));
  }

  static void deleteTweet(int index) => _box.deleteAt(index);

  static void editTweet(int index, String emoji) {
    final tweet = getSingleTweet(index).copyWith(emojis: emoji);
    _box.putAt(index, tweet.mapToDB());
  }

  static void addTweet(TweetModel tweet) => _box.add(tweet.mapToDB());
  static void addAllTweets(List<TweetModel> tweets) =>
      _box.addAll(tweets.map((e) => e.mapToDB()));
  static bool get isEmpty => _box.isEmpty;

  static void closeBox() => _box.close();

  static void clearBox() => _box.clear();
}
