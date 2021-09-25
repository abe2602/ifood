import 'package:flutter/widgets.dart';

import 'loading_indicator.dart';

class AsyncSnapshotResponseView<Loading, Success, Error>
    extends StatelessWidget {
  const AsyncSnapshotResponseView({
    required this.snapshot,
    required this.successWidgetBuilder,
    required this.errorWidgetBuilder,
    Key? key,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final Widget Function(Success success) successWidgetBuilder;
  final Widget Function(Error error) errorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.data;

    if (snapshotData == null || snapshotData is Loading) {
      return const LoadingIndicator();
    } else if (snapshotData is Error) {
      return errorWidgetBuilder(snapshotData);
    } else if (snapshotData is Success) {
      return successWidgetBuilder(snapshotData);
    }

    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
