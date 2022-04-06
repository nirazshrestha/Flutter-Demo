import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:network_module/ApiResponse.dart';
import 'package:repository_module/repository_module.dart';

import 'custom_stream_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PostBloc? _bloc;

    @override
  void initState() {
    super.initState();
    init();
  }

    @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  init() async {
    _bloc = PostBloc();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
         title: Text("Posts List")
        ),
      body: showPosts(),
    );
  }

  Widget showPosts() {
  return CustomStreamBuilder<List<Posts>>(
      stream: _bloc?.blocStream,
      sink: _bloc?.blocSink,
      initialWidget: Container(),
      builder: (context, snapshot) {
        //  SchedulerBinding.instance?.addPostFrameCallback((_) {
        //     navigateToOnBoardingView(context);
        //   });
      return Scaffold(
          body: ListView(
           children: [
             Card(
            child: ListTile(
              title:const Text("Hello World") ,
            )
          )
           ],
          ),
        );
      }
    );
  }
}
