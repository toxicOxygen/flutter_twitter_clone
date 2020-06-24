import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../extras/exceptions.dart';
import '../models/posts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';


class Tweet extends ChangeNotifier{
  String _baseUrl = "https://kwaku96.pythonanywhere.com";
  Post post;

  Tweet({
    @required this.post
  });

  Tweet.fromJson(Map<String,dynamic> json){
    post = Post.fromJson(json);
  }

  Future<void> toggleLike(String token) async{
    var url = "$_baseUrl/api/v1/posts/like_post/";
    return http.post(
      url,
      headers: {
        "Authorization":"Token $token",
        "Content-Type":"application/json",
      },
      body: {
        "id":post.id,
        "action":"like" //TODO change this later
      }
    ).then((value){
      if(value.statusCode != 200)
        throw HttpException('failed to like post');
      return json.decode(value.body);
    }).then((value){
      if(value['status'] == "ko")
        throw HttpException("failed to perform action");
      print(value);
    }).catchError((e){
      print(e);
      throw HttpException(e.toString());
    });
  }
}


class TweetProvider extends ChangeNotifier{

  String _baseUrl = "https://kwaku96.pythonanywhere.com";

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  List<Tweet> _posts = [];

  List<Tweet> get posts{
    return [..._posts];
  }

  Tweet getPostLocally(int id){
    return _posts.firstWhere((element) => element.post.id == id);
  }

  Future<void> getPosts() async{
    var url = "$_baseUrl/api/v1/posts/";

    return _getToken().then((value){
      _posts.clear();
      return http.get(
        url,
        headers: {
          "Authorization":"Token $value"
        }
      );
    }).then((value){
      var res = json.decode(value.body);
      if(value.statusCode != 200)
        throw HttpException(res['detail']);
      return json.decode(value.body);
    }).then((value){
      for(var item in value){
        _posts.add(Tweet.fromJson(item));
      }
      notifyListeners();
    }).catchError((e){
      print(e);
      throw HttpException(e.toString());
    });
  }

  Future<void> createPost(String tweet,List<Asset> images) async{
    var uri = Uri.parse('$_baseUrl/api/v1/posts/');
    http.MultipartRequest request = http.MultipartRequest('POST',uri);

    var _images = images.map((img) async{
      ByteData byteData = await img.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      String ext = img.name.split('.')[1]; print(ext);
      return http.MultipartFile.fromBytes(
          'file',
          imageData,
          filename: img.name,
          contentType: MediaType("image",ext.toLowerCase())
      );
    }).toList();
    String token = '';
    return _getToken().then((value){
      token = value;
      return Future.wait(_images);
    }).then((value){
      Map<String,String> headers = {"Authorization":"Token $token"};
      request.headers.addAll(headers);
      request.fields['tweet'] = tweet;
      request.files.addAll(value);
      print(request.fields);
      return request.send();
    }).then((value){
      if(value.statusCode != 201)
        throw HttpException("failed to add post");
      return value.stream.bytesToString();
    }).then((value){
      print(value);
      return json.decode(value);
    }).then((value){
      _posts.insert(0, Tweet.fromJson(value));
      notifyListeners();
    }).catchError((e){
      throw HttpException(e.toString());
    });
  }

  Future<String> _getToken() async{
    SharedPreferences prefs = await _pref;
    String token = prefs.get('token');
    if(token == null)
      throw HttpException('failed to get token');
    return token;
  }

  Future<Post> getPost(String id) async{
    var url = "$_baseUrl/api/v1/posts/$id";
    return _getToken().then((value){
      return value;
    }).then((value){
      return http.get(url);
    }).then((value){
      if(value.statusCode != 200)
        throw HttpException("Post was not retrieved");
      return json.decode(value.body);
    }).then((value){
      return Post.fromJson(value);
    }).catchError((e){
      throw HttpException(e.toString());
    });
  }

}