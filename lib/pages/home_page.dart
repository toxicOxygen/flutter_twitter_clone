import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/appbar_icon_widget.dart';
import './tweet_detail_page.dart';
import '../custom_widgets/tweet_card.dart';
import '../providers/tweet_provider.dart';

class HomePage extends StatelessWidget {
  final bool isLoading;

  HomePage({this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Consumer<TweetProvider>(
      builder: (ctx,tweetProvider,_){
        return RefreshIndicator(
          onRefresh: ()=>tweetProvider.getPosts(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.blue),
                backgroundColor: Colors.white,
                title: Text('Home',style: TextStyle(color: Colors.black)),
                leading: AppBarIconWidget(),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: (){},
                  )
                ],
                pinned: true,
              ),
              if(isLoading)
                SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(),),
                ),
              if(!isLoading)
                SliverList(
                  delegate: SliverChildBuilderDelegate((ctx,i){
                    return ChangeNotifierProvider.value(
                      value: tweetProvider.posts[i],
                      child: TweetCard(
                        post: tweetProvider.posts[i].post,
                        onTap: ()=>Navigator.of(context).pushNamed(
                            TweetDetailPage.tag,
                            arguments: {'post':tweetProvider.posts[i]}
                        ),
                      ),
                    );
                  },childCount: tweetProvider.posts.length),
                )
            ],
          ),
        );
      },
    );
  }
}
