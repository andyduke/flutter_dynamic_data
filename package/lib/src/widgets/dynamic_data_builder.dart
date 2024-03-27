import 'package:dynamic_data/src/dynamic_data.dart';
import 'package:dynamic_data/src/dynamic_data_error.dart';
import 'package:dynamic_data/src/dynamic_data_state.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_defaults.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_widgets_typedefs.dart';
import 'package:flutter/material.dart';

class DynamicDataBuilder<T> extends StatelessWidget {
  final DynamicData<T> data;
  final DynamicDataBuilderCallback<T> builder;
  final DynamicDataBuilderEmptyCallback? emptyBuilder;
  final DynamicDataBuilderErrorCallback? errorBuilder;
  final DynamicDataBuilderLoadingCallback? loadingBuilder;

  const DynamicDataBuilder({
    super.key,
    required this.data,
    required this.builder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: data,
      builder: (context, child) {
        switch (data.state) {
          case DynamicDataState.none:
            return const SizedBox.shrink();

          case DynamicDataState.loading:
            return _buildLoading(context);

          case DynamicDataState.loaded:
            return data.isEmpty
                ? _buildEmpty(context) //
                : _buildLoaded(context, data.data as T);

          case DynamicDataState.error:
            return _buildError(context, data.error!);
        }
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return (loadingBuilder ?? DynamicDataDefaults.of(context).loadingBuilder).call(context);
  }

  Widget _buildEmpty(BuildContext context) {
    return (emptyBuilder ?? DynamicDataDefaults.of(context).emptyBuilder).call(context);
  }

  Widget _buildLoaded(BuildContext context, T data) {
    return builder(context, data);
  }

  Widget _buildError(BuildContext context, DynamicDataError error) {
    return (errorBuilder ?? DynamicDataDefaults.of(context).errorBuilder).call(context, error, data.reload);
  }
}
