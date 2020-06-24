import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tweet_provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


class CreateTweetPage extends StatefulWidget {
  static String tag = 'create-tweet-page';

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  String _tweet = '';
  List<Asset> _images = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              child: Text('Tweet'),
              onPressed: ()=>_createPost(context),
              color: Colors.blue,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12,right:12,top: 5),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          maxLength: 280,
                          maxLines: 10,
                          minLines: 4,
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            border: InputBorder.none
                          ),
                          onChanged: (val)=>_tweet = val,
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                color: Colors.blue.withAlpha(180),
                              ),
                              onPressed: ()=> _loadAssets(),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 300,
              padding: const EdgeInsets.only(left:10,right:10),
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  _images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: AssetThumb(
                      asset: _images[index],
                      width: 290,
                      height: 300
                    ),
                  )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _createPost(BuildContext context) async{
    final provider = Provider.of<TweetProvider>(context,listen: false);
    
    return  provider.createPost(_tweet, _images).then((value){
      Navigator.of(context).pop();
    }).catchError((e){
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('$e'),
      ));
    });
  }

  Future<void> _loadAssets() async{
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Detected';

    try{
      resultList = await MultiImagePicker.pickImages(
        maxImages : 3,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Twitter clone",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    }catch(e){
      error = e.toString();
    }

    if(!mounted) return;

    setState(() {
      _images = resultList;
    });
  }
}
