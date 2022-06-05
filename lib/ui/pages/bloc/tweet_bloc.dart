import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/tweet_model.dart';
import '../../../repository/tweet_repository.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final TweetRepository _repository = TweetRepository();
  int selectedTweetIndex = -1;

  TweetBloc() : super(const TweetInitial(tweets: [])) {
    on<AddTweet>(_addTweet);
    on<AddEmojis>(_addEmojis);
    on<ShowEmojis>(_showEmojis);
    on<DeleteTweet>(_deleteTweet);
    on<GetTweetsEvent>(_getTweets);
  }

  Future<void> _getTweets(
      GetTweetsEvent event, Emitter<TweetState> emit) async {
    _repository.getTweets();
    emit(TweetInitial(tweets: _repository.tweets));
  }

  Future<void> _showEmojis(ShowEmojis event, Emitter<TweetState> emit) async {
    bool showEmoji = event._index != selectedTweetIndex;
    selectedTweetIndex = showEmoji ? event._index : -1;
    emit(TweetInitial(tweets: _repository.tweets, showEmojis: showEmoji));
  }

  Future<void> _addEmojis(AddEmojis event, Emitter<TweetState> emit) async {
    _repository.editTweet(selectedTweetIndex, event._emoji);
    selectedTweetIndex = -1;
    emit(TweetInitial(tweets: _repository.tweets, showEmojis: false));
  }

  Future<void> _addTweet(AddTweet event, Emitter<TweetState> emit) async {
    _repository.addTweet(title: event.title, subTitle: event.subTitle);
    emit(TweetInitial(tweets: _repository.tweets, showEmojis: false));
  }

  Future<void> _deleteTweet(DeleteTweet event, Emitter<TweetState> emit) async {
    _repository.deleteTweet(selectedTweetIndex);
    selectedTweetIndex = -1;
    emit(TweetInitial(tweets: _repository.tweets, showEmojis: false));
  }
}
