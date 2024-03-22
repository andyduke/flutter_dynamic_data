part of 'dynamic_data.dart';

class DynamicFutureData<T> extends DynamicData<T> {
  final Future<T?> Function() futureBuilder;

  DynamicFutureData({
    required this.futureBuilder,
    super.autoLoad,
    super.emptyDataChecker = DynamicData.defaultEmptyDataChecker,
  }) : super._();

  @override
  Future<void> load({bool reload = false}) async {
    if (state == DynamicDataState.loading) {
      return;
    }

    if (!reload && state == DynamicDataState.loaded) {
      return;
    }

    if (!reload) {
      reset();
    }

    try {
      // Do load
      setData(await futureBuilder());
    } catch (e, stack) {
      setError(e, stack);
      // rethrow;
    }
  }
}
