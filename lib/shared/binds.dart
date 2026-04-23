import 'package:auto_injector/auto_injector.dart';

class Binds {
  final AutoInjector _injector;
  const Binds._(this._injector);

  factory Binds() => _instance;
  static final Binds _instance = Binds._(AutoInjector());

  void setup() {}

  T get<T>() => _injector.get<T>();
}
