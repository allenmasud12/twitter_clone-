class TweetModel {
    String auther;
    String body;
    DateTime postedAt;
    String id;

    TweetModel({
        required this.auther,
        required this.body,
        required this.postedAt,
        required this.id,
    });

    factory TweetModel.fromJson(Map<String, dynamic> json) => TweetModel(
        auther: json["auther"],
        body: json["body"],
        postedAt: DateTime.parse(json["posted_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "auther": auther,
        "body": body,
        "posted_at": postedAt.toIso8601String(),
        "id": id,
    };
}
