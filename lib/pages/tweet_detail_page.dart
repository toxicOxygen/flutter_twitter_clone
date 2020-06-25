import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/custom_widgets/tweet_card.dart';
import './add_comment_page.dart';
import '../custom_widgets/tweet_detail_widget.dart';
import '../providers/tweet_provider.dart';

class TweetDetailPage extends StatelessWidget {
  static String tag = 'tweet-detail-page';

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> t = ModalRoute.of(context).settings.arguments;
    Tweet _tweet = t['post'] as Tweet;

    return ChangeNotifierProvider.value(
      value: _tweet,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tweet',style: TextStyle(color: Colors.black),),
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat_bubble_outline),
          onPressed: ()=>Navigator.of(context).pushNamed(AddCommentPage.tag,arguments: _tweet.post.id),
        ),
        body: Consumer<Tweet>(
          builder: (ctx,tweet,_){
            return ListView.builder(
              itemBuilder: (ctx,i){
                if(i == 0){
                  return TweetDetailWidget(
                    post: _tweet.post,
                  );
                }
                return TweetCard(
                  comment: tweet.post.comments[i-1],
                  isComment: true,
                );
              },
              itemCount: tweet.post.comments.length + 1,
            );
          }
        ),
      ),
    );
  }
}
