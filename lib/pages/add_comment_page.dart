import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tweet_provider.dart';

class AddCommentPage extends StatelessWidget {
  static String tag = 'add-comment-page';

  @override
  Widget build(BuildContext context) {
    final int targetPostId = ModalRoute.of(context).settings.arguments;
    final tweetProvider = Provider.of<TweetProvider>(context,listen: false);//might change listen to true
    final post = tweetProvider.getPostLocally(targetPostId);
    String comment = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35)
              ),
              textColor: Colors.white,
              child: Text('Comment'),
              onPressed: ()=>_addComment(context,post, comment),
              color: Colors.blue,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 25,
                    backgroundImage: NetworkImage('https://tinyurl.com/yawxco2g'),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              text: '${post.post.user.username} ',
                              children: [
                                TextSpan(
                                  text: '@bk_${post.post.user.username}   16h',
                                  style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black45)
                                )
                              ]
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "${post.post.tweet}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black54
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 25,
                  minRadius: 20,
                  backgroundImage: NetworkImage('https://tinyurl.com/yakkyll3'),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    maxLength: 140,
                    maxLines: 10,
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Type your comment',
                      border: InputBorder.none
                    ),
                    onChanged: (val)=>comment = val,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _addComment(BuildContext context,Tweet tweet,String comment) async{
    if(comment.isEmpty)
      return; //TODO show snackbar
    tweet.addComment(comment).then((value){
      Navigator.of(context).pop();
    }).catchError((e){
      print(e);
    });
  }
}
