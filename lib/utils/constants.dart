import '../models/tweet_model.dart';

class HiveKeys {
  static const tweetBoxKey = 'tweets';
}

const List<String> emojiList = ['😂', '😈', '🧡', '👍', '👎', '😊', '🥰', '🤯'];
const List<TweetModel> mockTweets = [
  TweetModel(
      title: 'Micheal Jordan', subTitle: 'First tweet on twitter', emojis: []),
  TweetModel(title: 'Julia Smith', subTitle: 'subTitle', emojis: []),
  TweetModel(title: 'Williams', subTitle: 'Topic of the day', emojis: []),
  TweetModel(title: 'Santa Clause', subTitle: 'subTitle', emojis: []),
  TweetModel(title: 'Egor Creed', subTitle: 'I love Music', emojis: []),
  TweetModel(
      title: 'Austine', subTitle: 'I love tweeting and reading', emojis: []),
  TweetModel(title: 'Steve Jobs', subTitle: 'Macbook is the best', emojis: []),
  TweetModel(
      title: 'Angelina Jolie',
      subTitle: 'I am releasing a new movie',
      emojis: []),
  TweetModel(title: 'Richard', subTitle: 'This is my first tweet', emojis: []),
  TweetModel(
      title: 'Marina Davis', subTitle: 'React Native is easy', emojis: []),
  TweetModel(title: 'David', subTitle: 'I love flutter and Dart', emojis: []),
];
