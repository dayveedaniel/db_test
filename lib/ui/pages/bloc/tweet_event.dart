part of 'tweet_bloc.dart';

@immutable
abstract class TweetEvent {
  const TweetEvent();
}

class GetTweetsEvent extends TweetEvent {}

class ShowEmojis extends TweetEvent {
  final int _index;
  const ShowEmojis(this._index);
}

class AddEmojis extends TweetEvent {
  final String _emoji;
  const AddEmojis(this._emoji);
}

class AddTweet extends TweetEvent {
  final String title;
  final String subTitle;
  const AddTweet({required this.title, required this.subTitle});
}

class DeleteTweet extends TweetEvent {
  const DeleteTweet();
}
