import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:twitter_app/data/model/tweet_model.dart';

class TweetDatasource{
 static Future<List<TweetModel>> getAllTweets() async {
  List <TweetModel> tweetList = [];
  http.Response res = await http.get(Uri.parse("https://658fc671cbf74b575eca2089.mockapi.io/tweet"));
  if(res.statusCode == 200){
    List parsedJson = jsonDecode(res.body);

    parsedJson.forEach((tweet) { 
      tweetList.add(TweetModel.fromJson(tweet));
    });
  }
  return tweetList;
  }


  static Future<bool> postTweet(TweetModel tweetModel) async {
    // if(name == null && tweet == null) {
    //   return false;
    // } 

    http.Response res = await http.post(Uri.parse("https://658fc671cbf74b575eca2089.mockapi.io/tweet"),
    body: tweetModel.toJson());
    if(res.statusCode == 200){
      return true;
    }
    return false;
  }
}