import 'package:flutter/cupertino.dart';
import 'package:ifood/presentation/common/subscription_holder.dart';
import 'package:rxdart/rxdart.dart';

class ActionHandler<T> extends StatefulWidget {
  const ActionHandler({
    required this.inputStream,
    required this.resultStream,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Stream<T> inputStream;
  final ValueChanged<T> resultStream;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _ActionHandlerState<T>();
}

class _ActionHandlerState<T> extends State<ActionHandler<T>>
    with SubscriptionHolder {
  @override
  void initState() {
    super.initState();

    widget.inputStream.listen(widget.resultStream).addTo(subscriptions);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
