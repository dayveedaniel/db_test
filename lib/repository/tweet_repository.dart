import 'package:db_test_app/data/db_handler.dart';
import 'package:db_test_app/utils/constants.dart';

import '../models/tweet_model.dart';

class TweetRepository {
  List<TweetModel> tweets = [];

  void getTweets() {
    if (DataBaseHandler.isEmpty) {
      DataBaseHandler.addAllTweets(mockTweets);
    }
    tweets = DataBaseHandler.getAllEntries();
  }

  void editTweet(int index, String emoji) {
    DataBaseHandler.editTweet(index, emoji);
    tweets = DataBaseHandler.getAllEntries();
  }

  void addTweet({required String title, required String subTitle}) {
    DataBaseHandler.addTweet(
        TweetModel(title: title, subTitle: subTitle, emojis: []));
    tweets = DataBaseHandler.getAllEntries();
  }

  void deleteTweet(int index) {
    DataBaseHandler.deleteTweet(index);
    tweets = DataBaseHandler.getAllEntries();
  }
}
