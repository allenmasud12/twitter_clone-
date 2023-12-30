
import 'dart:convert';
class TweetModel {
    String auther;
    String body;
    DateTime? postedAt;
    String? id;

    TweetModel({
        required this.auther,
        required this.body,
        this.postedAt,
        this.id,
    });

    factory TweetModel.fromJson(Map<String, dynamic> json) => TweetModel(
        auther: json["auther"],
        body: json["body"],
        postedAt: DateTime.parse(json["posted_at"]),
        id: json["id"],
    );

    Map<String, String> toJson() {
        Map<String, String> data = {};
        data["auther"] = auther?? "annon user";
        data["body"] = body?? "empty";
        return data; 
    }
}
