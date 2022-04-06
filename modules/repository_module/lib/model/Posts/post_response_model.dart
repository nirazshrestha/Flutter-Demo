import 'dart:convert';

List<Posts> postsFromJson(String str) => List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
    Posts({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    int? userId;
    int? id;
    String? title;
    String? body;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

  // factory Posts.fromJSON(Map<String, dynamic> parsedJson) {
  //   return Posts(
  //     userId: parsedJson["userId"],
  //       id: parsedJson["id"],
  //       title: parsedJson["title"],
  //       body: parsedJson["body"],
  //   );
  // }

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}