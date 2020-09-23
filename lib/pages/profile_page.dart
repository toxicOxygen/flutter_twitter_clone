import 'package:flutter/material.dart';
import '../custom_widgets/tweet_card.dart';
import '../extras/general_func_and_const.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import './create_tweet_page.dart';
import '../custom_widgets/profile_photo_main_widget.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';

class ProfilePage extends StatelessWidget {
  static String tag = 'profile-page';

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return SubProfile(user: user);
  }
}


class SubProfile extends StatelessWidget {
  final User user;

  SubProfile({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TweetProvider>(context);
    final numOfTweets = provider.userTweets(user.id).length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
        title: ListTile(
          title: Text(
            '${user.username}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('$numOfTweets tweet${pluralize(numOfTweets)}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).pushNamed(CreateTweetPage.tag),
      ),
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfilePhotoMainWidget(user: user,),
              TabBar(
                tabs: <Widget>[
                  Tab(text: 'Tweets',),
                  Tab(text: 'Tweets & replies',),
                  Tab(text: 'Media',),
                  Tab(text: 'Likes',),
                ],
                labelColor: Colors.black54,
                isScrollable: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

