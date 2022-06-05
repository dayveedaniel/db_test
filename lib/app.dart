import 'package:db_test_app/ui/pages/bloc/tweet_bloc.dart';
import 'package:db_test_app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        lazy: false,
        create: (context) => TweetBloc()..add(GetTweetsEvent()),
        child: const MyHomePage(),
      ),
    );
  }
}
