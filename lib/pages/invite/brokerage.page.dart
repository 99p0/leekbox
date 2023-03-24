import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox_infra/log/log.dart';

///
class BrokeragePage extends ConsumerStatefulWidget {
  @override
  _BrokeragePageState createState() => _BrokeragePageState();
}

class _BrokeragePageState extends ConsumerState<BrokeragePage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('BrokeragePage build');
    return Scaffold(
      body: Center(
        child: Text("BrokeragePage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
