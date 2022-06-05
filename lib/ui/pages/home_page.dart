import 'package:db_test_app/ui/pages/bloc/tweet_bloc.dart';
import 'package:db_test_app/ui/widgets/custom_alert_dialog.dart';
import 'package:db_test_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showEmoji = context.select((TweetBloc bloc) => bloc.state.showEmojis);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweets'),
        bottom: showEmoji
            ? const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: _EmojiRow(),
              )
            : null,
      ),
      body: const _Body(),
      floatingActionButton: const _FloatingButton(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Center(child: BlocBuilder<TweetBloc, TweetState>(
      builder: (context, state) {
        final tweetsWithEmoji =
            state.tweets.where((tweet) => tweet.emojis.isNotEmpty).length;
        return ListView.builder(
            itemCount: state.tweets.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Tweets with reactions : $tweetsWithEmoji',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }
              final int newIndex = index - 1;
              final tweet = state.tweets[newIndex];
              bool isSelected =
                  context.read<TweetBloc>().selectedTweetIndex == newIndex;
              return ListTile(
                selected: isSelected,
                selectedTileColor: Colors.black12,
                leading: const FlutterLogo(),
                trailing: isSelected
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.redAccent,
                        ),
                        onPressed: () async {
                          bool canDelete =
                              await AlertUtils.deleteTweetDialog(context);
                          if (canDelete) {
                            context.read<TweetBloc>().add(const DeleteTweet());
                          }
                        })
                    : null,
                onTap: () {
                  context.read<TweetBloc>().add(ShowEmojis(newIndex));
                },
                isThreeLine: true,
                title: Text(
                  tweet.title,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  '${tweet.subTitle}\nReactions: ${tweet.emojis.join(',')}',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            });
      },
    ));
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<TweetBloc>(context),
            child: _DialogBody(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class _DialogBody extends StatelessWidget {
  _DialogBody({
    Key? key,
  }) : super(key: key);

  final _titleController = TextEditingController();
  final _subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Add Tweet'),
      content: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title'),
            TextField(controller: _titleController),
            const SizedBox(height: 20),
            const Text('Subtitle'),
            TextField(controller: _subTitleController),
            const SizedBox(height: 20),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _subTitleController.text.isNotEmpty) {
                    context.read<TweetBloc>().add(AddTweet(
                        title: _titleController.text,
                        subTitle: _subTitleController.text));
                  }
                  Navigator.pop(context);
                },
                color: Colors.blueAccent,
                child: const Text('Add'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmojiRow extends StatelessWidget {
  const _EmojiRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Add Reaction to tweet'),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: emojiList.length,
                  itemBuilder: (context, index) {
                    final String emoji = emojiList[index];
                    return Transform.scale(
                      scale: 1.3,
                      child: IconButton(
                        icon: Text(emoji),
                        onPressed: () {
                          context.read<TweetBloc>().add(AddEmojis(emoji));
                        },
                      ),
                    );
                  }),
            ),
          ]),
    );
  }
}
