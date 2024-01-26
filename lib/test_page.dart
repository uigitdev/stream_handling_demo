import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stream_handling/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:uigitdev_stream_holder/uigitdev_stream_holder.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late StreamSubscription<int> subscription;
  late StreamSubscription<int?> subscription2;

  @override
  void initState() {
    subscription = context.read<MyProvider>().numberStream.stream.listen((event) {
      print(event);
    });

    subscription2 = context.read<MyProvider>().numberStreamHolder.stream.listen((event) {
      print(event);
    });


    context.read<MyProvider>().initData();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    subscription2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('StreamBuilder'),
              StreamBuilder<int>(
                stream: context.watch<MyProvider>().numberStream.stream,
                //initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data}');
                  } else if (snapshot.hasError) {
                    return Text('error: ${snapshot.error}');
                  } else {
                    return Text('loading');
                  }
                },
              ),
              TextButton(
                onPressed: () => context.read<MyProvider>().addNumber(Random().nextInt(50)),
                child: Text('Add new number'),
              ),
              TextButton(
                onPressed: () => context.read<MyProvider>().numberStream.addError(ErrorHint('no-data')),
                child: Text('Add Error'),
              ),
              Text('---------------'),
              Text('StreamHolder'),
              StreamHolderBuilder<int?>(
                streamHolder: context.watch<MyProvider>().numberStreamHolder,
                builder: (context, state, data, error) {
                  switch (state) {
                    case StreamHolderState.none:
                      return Text('loading');
                    case StreamHolderState.hasError:
                      return Text('error');
                    case StreamHolderState.hasData:
                      return Text('data: $data');
                  }
                },
              ),
              TextButton(
                onPressed: () => context.read<MyProvider>().numberStreamHolder.addData(Random().nextInt(50)),
                child: Text('Add number'),
              ),
              TextButton(
                onPressed: () => context.read<MyProvider>().numberStreamHolder.addError(ErrorHint('no-data')),
                child: Text('Add error'),
              ),
              TextButton(
                onPressed: () => print(context.read<MyProvider>().numberStreamHolder.data),
                child: Text('Get current data'),
              ),
            ],
          ),
        ),
      );
}
