part of 'tweet_bloc.dart';

@immutable
abstract class TweetState {
  final List<TweetModel> tweets;
  final bool showEmojis;
  const TweetState({required this.tweets, required this.showEmojis});
}

class TweetInitial extends TweetState {
  const TweetInitial({required super.tweets, super.showEmojis = false});
}
