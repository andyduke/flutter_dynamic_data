import 'package:dynamic_data/src/dynamic_data.dart';
import 'package:dynamic_data/src/dynamic_data_error.dart';
import 'package:dynamic_data/src/dynamic_data_state.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_defaults.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_widgets_typedefs.dart';
import 'package:flutter/widgets.dart';

@Deprecated('Legacy implementation')
class DynamicDataBuilderOld<T> extends StatefulWidget {
  final DynamicData<T> data;
  final DynamicDataBuilderCallback<T> builder;
  final DynamicDataBuilderEmptyCallback? emptyBuilder;
  final DynamicDataBuilderErrorCallback? errorBuilder;
  final DynamicDataBuilderLoadingCallback? loadingBuilder;

  const DynamicDataBuilderOld({
    super.key,
    required this.data,
    required this.builder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  State<DynamicDataBuilderOld<T>> createState() => _DynamicDataBuilderOldState<T>();
}

// ignore: deprecated_member_use_from_same_package
class _DynamicDataBuilderOldState<T> extends State<DynamicDataBuilderOld<T>> {
  @override
  void initState() {
    super.initState();
    widget.data.addListener(_onStatefulDataChanged);
  }

  @override
  // ignore: deprecated_member_use_from_same_package
  void didUpdateWidget(DynamicDataBuilderOld<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(_onStatefulDataChanged);
      widget.data.addListener(_onStatefulDataChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(_onStatefulDataChanged);
    super.dispose();
  }

  void _onStatefulDataChanged() {
    setState(() {});
  }

  Widget _buildLoading() {
    return (widget.loadingBuilder ?? //
            DynamicDataDefaults.of(context).loadingBuilder //
        // (context) => const DynamicDataLoadingView() //
        )
        .call(context);
  }

  Widget _buildEmpty() {
    return (widget.emptyBuilder ?? //
            DynamicDataDefaults.of(context).emptyBuilder //
        // (context) => const SizedBox.shrink() //
        )
        .call(context);
  }

  Widget _buildLoaded(T data) {
    return widget.builder(context, data);
  }

  Widget _buildError(DynamicDataError error) {
    return (widget.errorBuilder ?? //
            DynamicDataDefaults.of(context).errorBuilder //
        // (context, errorDetails) => DynamicDataErrorView(error: error.error, stackTrace: error.stackTrace) //
        )
        .call(context, error);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.data.state) {
      case DynamicDataState.none:
        return const SizedBox.shrink();

      case DynamicDataState.loading:
        return _buildLoading();

      case DynamicDataState.loaded:
        return widget.data.isEmpty
            ? _buildEmpty() //
            : _buildLoaded(widget.data.data as T);

      case DynamicDataState.error:
        return _buildError(widget.data.error!);
    }
  }
}
