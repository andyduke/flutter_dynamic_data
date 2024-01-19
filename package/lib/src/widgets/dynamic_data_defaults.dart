import 'package:dynamic_data/src/widgets/dynamic_data_error_view.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_loading_view.dart';
import 'package:dynamic_data/src/widgets/dynamic_data_widgets_typedefs.dart';
import 'package:flutter/widgets.dart';

class DynamicDataDefaults extends InheritedWidget {
  static DynamicDataBuilderEmptyCallback defaultEmptyBuilder = (context) => const SizedBox.shrink();
  static DynamicDataBuilderLoadingCallback defaultLoadingBuilder = (context) => const DynamicDataLoadingView();
  static DynamicDataBuilderErrorCallback defaultErrorBuilder =
      (context, error) => DynamicDataErrorView(error: error.error, stackTrace: error.stackTrace);

  static DynamicDataDefaultValues defaults = DynamicDataDefaultValues(
    emptyBuilder: defaultEmptyBuilder,
    loadingBuilder: defaultLoadingBuilder,
    errorBuilder: defaultErrorBuilder,
  );

  late final DynamicDataDefaultValues data;

  DynamicDataDefaults({
    super.key,
    DynamicDataBuilderEmptyCallback? emptyBuilder,
    DynamicDataBuilderLoadingCallback? loadingBuilder,
    DynamicDataBuilderErrorCallback? errorBuilder,
    required super.child,
  }) {
    data = DynamicDataDefaultValues(
      emptyBuilder: emptyBuilder ?? defaultEmptyBuilder,
      loadingBuilder: loadingBuilder ?? defaultLoadingBuilder,
      errorBuilder: errorBuilder ?? defaultErrorBuilder,
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DynamicDataDefaultValues of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DynamicDataDefaults>()?.data ?? defaults;
  }
}

class DynamicDataDefaultValues {
  final DynamicDataBuilderEmptyCallback emptyBuilder;
  final DynamicDataBuilderLoadingCallback loadingBuilder;
  final DynamicDataBuilderErrorCallback errorBuilder;

  const DynamicDataDefaultValues({
    required this.emptyBuilder,
    required this.loadingBuilder,
    required this.errorBuilder,
  });
}
