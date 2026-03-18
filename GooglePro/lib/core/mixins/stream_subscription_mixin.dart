import 'dart:async';

mixin StreamSubscriptionMixin {
  final List<StreamSubscription> _subscriptions = [];

  void addSubscription(StreamSubscription sub) => _subscriptions.add(sub);

  void cancelAllSubscriptions() {
    for (final sub in _subscriptions) { sub.cancel(); }
    _subscriptions.clear();
  }
}
