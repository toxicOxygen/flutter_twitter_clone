import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import '../pages/add_comment_page.dart';
import './custom_bottom_sheet.dart';

class TweetOptionsBar extends StatelessWidget {
  final int id;
  const TweetOptionsBar({
    Key key,
    this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final post = Provider.of<Tweet>(context,listen: true);
    var _user = Provider.of<UserProvider>(context).currentUser;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Consumer<Tweet>(
          builder: (ctx,tweet,_){
            return CustomIconButton(
              count: (tweet.post.comments?? []).length,
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: (){
                Navigator.of(context).pushNamed(AddCommentPage.tag,arguments: id);
              },
            );
          }
        ),
        CustomIconButton(
          count: 0,
          icon: Icon(Icons.refresh),
          onPressed: (){
            Scaffold.of(context).showBodyScrim(true, 0.3);
            Scaffold.of(context).showBottomSheet((context)=>BottomSheet(
              builder: (ctx)=>CustomBottomSheet(),
              onClosing: (){},
            ));
          },
        ),
        Consumer<Tweet>(
          builder: (ctx,tweet,_){
            return CustomIconButton(
              count: (tweet.post.usersLike ?? []).length,
              icon: Icon(
                tweet.isLiked(_user.id)?
                Icons.favorite:
                Icons.favorite_border
              ),
              onPressed: (){
                final currentUser = Provider.of<UserProvider>(context,listen: false).currentUser;
                tweet.toggleLike(currentUser.id);
              },
            );
          },
        ),
      ],
    );
  }
}



class CustomIconButton extends StatelessWidget {

  final Icon icon;
  final VoidCallback onPressed;
  final int count;

  CustomIconButton({
    this.count = 0,
    this.icon,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      textColor: Colors.black54,
      icon: icon,
      label: Text('$count'),
      onPressed: onPressed,
    );
  }
}