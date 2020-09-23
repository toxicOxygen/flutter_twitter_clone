import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../providers/tweet_provider.dart';
import 'dart:math' as math;

class TweetImageViewPage extends StatelessWidget {
  static String tag = 'tweet-images-view-page';

  final List<Color> _colors = [
    Colors.brown,
    Color.fromRGBO(52, 58, 64, 1.0),
    Color.fromRGBO(55, 125, 61, 1.0),
    Color.fromRGBO(180, 153, 124, 1.0),
    Color.fromRGBO(38, 39, 47, 1.0)
  ];

  @override
  Widget build(BuildContext context) {
    Map<String,int> id = ModalRoute.of(context).settings.arguments;
    var post = Provider.of<TweetProvider>(
      context,
      listen: false
    ).getPostLocally(id['id']);

    var index = math.Random().nextInt(_colors.length) ;

    return Scaffold(
      backgroundColor: _colors[index],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: (){},
          )
        ],
      ),
      body: Center(
        child: CarouselSlider.builder(
          itemBuilder: (ctx,i){
            return Image.network(
              post.post.images[i].image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
            );
          },
          itemCount: post.post.images.length,
          options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 1,
            enlargeCenterPage: false,
            aspectRatio: 3/4
          ),
        ),
      ),
      //TODO split this into a separate widget
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
              onPressed: (){},
              icon: Icon(Icons.chat_bubble_outline),
              label: Text('12'),
              textColor: Colors.white,
            ),
            FlatButton.icon(
              onPressed: (){},
              icon: Icon(Icons.refresh),
              label: Text('2'),
              textColor: Colors.white,
            ),
            FlatButton.icon(
              onPressed: (){},
              icon: Icon(Icons.favorite_border),
              label: Text('21'),
              textColor: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.share,color: Colors.white,),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
