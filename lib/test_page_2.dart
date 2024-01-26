import 'package:flutter/material.dart';
import 'package:stream_handling/my_provider.dart';
import 'package:uigitdev_stream_holder/uigitdev_stream_holder.dart';
import 'package:provider/provider.dart';

class TestPage2 extends StatelessWidget {
  const TestPage2({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ),
    ),
  );
}
