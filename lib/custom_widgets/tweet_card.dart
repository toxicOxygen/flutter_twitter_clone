import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import './tweet_option_bar.dart';
import '../models/posts.dart';
import '../models/comments.dart';
import './images_grid_widget.dart';

class TweetCard extends StatelessWidget {
  final Post post;
  final Comment comment;
  final bool isComment;
  final VoidCallback onTap;

  TweetCard({
    this.onTap,
    this.post,
    this.comment,
    this.isComment = false
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final username = !isComment ? post.user.username : comment.user.username;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12)
        )
      ),
      padding: const EdgeInsets.only(top: 3),
      constraints: BoxConstraints(
        maxHeight: height * 0.45,
        minHeight: height * 0.10,
        maxWidth: width
      ),
      child: Card(
        elevation: 0.0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 20,
                  maxRadius: 25,
                  backgroundImage: NetworkImage('https://tinyurl.com/yawxco2g'),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: username,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.of(context).pushNamed(
                                    ProfilePage.tag,
                                    arguments: isComment?comment.user:post.user
                                );
                              },
                            ),
                            TextSpan(
                              text: ' @bk_$username',
                              style: TextStyle(color: Colors.black45),
                            )
                          ]
                        ),
                      ),
                      Text(
                        !isComment?post.tweet:comment.comment,
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(height: 5,),
                      _imageSection(height),
                      if(!isComment)
                        TweetOptionsBar(id: !isComment? post.id: comment.id)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageSection(double height){
    if(isComment)
      return Container(height: 0.0001,);
    return post.images.isEmpty ? Container(height: 0.001,):
    ImagesGridWidget(
      images: post.images,
      height: height * .23,
      postId: post.id,
    );
  }
}

