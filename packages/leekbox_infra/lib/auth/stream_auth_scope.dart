import 'package:flutter/widgets.dart';

import 'stream_auth_notifier.dart';
import 'stream_auth.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          notifier: StreamAuthNotifier(),
          child: child,
        );

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}
