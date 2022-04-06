import 'dart:async';
import 'package:network_module/ApiResponse.dart';
import 'package:repository_module/repository_module.dart';

class PostBloc {

  PostRepository? _postRepository;
  StreamController<ApiResponse<List<Posts>>>? _controller;


    PostBloc() {
    _controller = StreamController<ApiResponse<List<Posts>>>();
    _postRepository = PostRepository();
    getPostsList();
  }

    StreamSink<ApiResponse<List<Posts>>> get blocSink =>
      _controller!.sink;

  Stream<ApiResponse<List<Posts>>> get blocStream =>
      _controller!.stream;

  
  getPostsList() async {
    blocSink.add(ApiResponse.loading('Fetching'));
    try {
      List<Posts>? responseData =
          await _postRepository?.getPostsList();
        blocSink.add(ApiResponse.completed(responseData));
  
    } catch (e) {
      return [];
    }
  }

  dispose() {
    _controller?.close();
  }

}