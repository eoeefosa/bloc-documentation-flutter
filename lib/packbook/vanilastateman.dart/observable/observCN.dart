import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
part 'mergin.dart';

abstract class Listenable {
  const Listenable();

  factory Listenable.merge(List<Listenable?> listenables) = _MergingListenable;

  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}

abstract class ValueListenable<T> extends Listenable {
  const ValueListenable();
  T get value;
}

class ChangeNotifier implements Listenable {
  int _count = 0;
  List<VoidCallback?> _listeners = [];

  @protected
  bool get hasListeners => _count > 0;

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @mustCallSuper
  void dispose() {
    _listeners = [];
    _count = 0;
  }

  void notifyListerners() {}
}

class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  ValueNotifier(this._value);
  T _value;
  @override
  // TODO: implement value
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    notifyListerners();
  }
}
