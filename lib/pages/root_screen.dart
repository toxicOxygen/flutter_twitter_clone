import 'package:flutter/material.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import '../pages/create_tweet_page.dart';
import '../custom_widgets/bottom_navigator.dart';
import '../custom_widgets/sidebar_widget.dart';
import './home_page.dart';
import './messages_page.dart';
import './notifications_page.dart';
import './search_page.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static String tag = 'root-screen';

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {_isLoading = true; });
      Future.wait([
        Provider.of<TweetProvider>(context).getPosts(),
        Provider.of<UserProvider>(context).fetchCurrentUser()
      ]).then((value){
        setState(() {_isLoading = false; });
      }).catchError((e){
        setState(() {_isLoading = false; });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _pages = [
      HomePage(isLoading: _isLoading,),
      SearchTweetPage(),
      NotificationsPage(),
      MessagesPage(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_currentIndex == 3){

          }else{
            Navigator.of(context).pushNamed(CreateTweetPage.tag);
          }
        },
        child: Icon(_currentIndex==3?Icons.mail_outline:Icons.add),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: MyBottomNavigationBar(
        currentPageIndex: _currentIndex,
        onTap: (i){
          setState(() { _currentIndex = i; });
        },
      ),
      drawer: Drawer(child: SideBarWidget()),
      body: _pages[_currentIndex],
    );
  }
}

