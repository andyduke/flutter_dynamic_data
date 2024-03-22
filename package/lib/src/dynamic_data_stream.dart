part of 'dynamic_data.dart';

class DynamicStreamData<T> extends DynamicData<T> {
  final Future<Stream<T?>> Function() streamBuilder;

  StreamSubscription? _subscription;

  DynamicStreamData({
    required this.streamBuilder,
    super.autoLoad,
    super.emptyDataChecker = DynamicData.defaultEmptyDataChecker,
  }) : super._();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

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
      // Cancel previous subscription
      await _subscription?.cancel();

      // Get stream
      final stream = await streamBuilder();

      // Set first data entry
      setData(null);

      // Listen
      _subscription = stream.listen(
        (result) {
          setData(result);
        },
        onError: (e, stack) {
          setError(e, stack);
        },
        cancelOnError: false,
      );
    } catch (e, stack) {
      setError(e, stack);
      // rethrow;
    }
  }
}
