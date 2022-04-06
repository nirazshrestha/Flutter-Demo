import 'dart:convert';
import 'package:network_module/network_module.dart';
import 'package:repository_module/repository_module.dart';

class PostRepository {

  final ApiBaseHelper _helper = ApiBaseHelper();

    Future<List<Posts>> getPostsList() async {

    final response = await _helper.send(WebService.posts, null,  HTTPMethod.GET, ParameterEncoding.JSON_ENCODING);
    var model = List<Posts>.from(
   response.data.map((x) => Posts.fromJson(x)));
    // List<Posts> listUsers = response.map((i) => Posts.fromJSON(i)).toList();
    // List<Posts> categories = (map['categories'] as List)?.map((response) => response as String)?.toList();
    return model;
    // final responseRP = Posts.fromJson(response) as List;
    // return responseRP;
  }

}