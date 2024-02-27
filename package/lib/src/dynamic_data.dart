import 'dart:async';
import 'package:dynamic_data/src/dynamic_data_error.dart';
import 'package:dynamic_data/src/dynamic_data_state.dart';
import 'package:flutter/foundation.dart';

part 'dynamic_data_future.dart';
part 'dynamic_data_stream.dart';

typedef DynamicDataEmptyChecker<T> = bool Function(T? data);

abstract class DynamicData<T> with ChangeNotifier {
  static const bool defaultAutoLoad = true;

  static bool defaultEmptyDataChecker(Object? data) => (data == null);

  factory DynamicData({
    required Future<T?> Function() futureBuilder,
    bool autoLoad = defaultAutoLoad,
  }) {
    return DynamicFutureData<T>(futureBuilder: futureBuilder, autoLoad: autoLoad);
  }

  factory DynamicData.stream({
    required Future<Stream<T?>> Function() streamBuilder,
    bool autoLoad = defaultAutoLoad,
  }) {
    return DynamicStreamData<T>(streamBuilder: streamBuilder, autoLoad: autoLoad);
  }

  final bool autoLoad;
  final DynamicDataEmptyChecker<T> emptyDataChecker;

  DynamicDataError? get error => _error;
  DynamicDataError? _error;
  bool get hasError => (_state == DynamicDataState.loaded) && (_error != null);

  T? get data => _data;
  T? _data;
  bool get hasData => (_state == DynamicDataState.loaded) && (_data != null);

  @protected
  reset() {
    _state = DynamicDataState.loading;
    _data = null;
    _isEmpty = null;
    _error = null;
    notifyListeners();
  }

  @protected
  void setData(T? data) {
    _data = data;
    _isEmpty = null;
    _state = DynamicDataState.loaded;
    notifyListeners();
  }

  @protected
  void setError(Object error, StackTrace? stackTrace) {
    _data = null;
    _isEmpty = null;
    _error = DynamicDataError(error: error, stackTrace: stackTrace);
    _state = DynamicDataState.error;
    notifyListeners();
  }

  bool get isEmpty => (_state == DynamicDataState.loaded) && (_isEmpty ??= isEmptyData(_data));
  bool? _isEmpty;

  bool get isLoading => _state == DynamicDataState.loading;

  DynamicData._({
    this.autoLoad = defaultAutoLoad,
    this.emptyDataChecker = defaultEmptyDataChecker,
  }) {
    if (autoLoad) {
      load();
    }
  }

  DynamicDataState get state => _state;
  DynamicDataState _state = DynamicDataState.none;

  Future<void> load({bool reload = false});

  Future<void> reload() {
    return load(reload: true);
  }

  bool isEmptyData(T? data) {
    return emptyDataChecker.call(data);
  }
}
