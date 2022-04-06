import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:network_module/network_module.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  late final Stream<ApiResponse<T>>? stream;
  late final StreamSink<ApiResponse<T>>? sink;
  final Widget initialWidget;
  final Widget Function(BuildContext context, T? state) builder;

  CustomStreamBuilder({required this.stream, required this.sink, required this.builder, required this.initialWidget});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<T>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.status) {
                        case Status.LOADING:
                          SchedulerBinding.instance?.addPostFrameCallback((_) {
                          });
                          break; 
                        case Status.COMPLETED:
                           
                            return builder(context, snapshot.data?.data);
                        case Status.ERROR:
                          SchedulerBinding.instance?.addPostFrameCallback((_) {
                            // SnackbarUtils.showSnackbar(context,
                            //     message: snapshot.data?.message ?? "",
                            //     icon: Icons.error,
                            //     type: SnackBarType.error);
                            sink?.add(ApiResponse.clear());
                          });
                          break;
                        case Status.CLEAR:
                        // print("error here");
                          break;
                      }
        }
        return initialWidget;
      },
    );
  }
}