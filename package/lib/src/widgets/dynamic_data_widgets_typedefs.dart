import 'package:dynamic_data/src/dynamic_data_error.dart';
import 'package:flutter/widgets.dart';

typedef DynamicDataBuilderCallback<T> = Widget Function(BuildContext context, T data);
typedef DynamicDataBuilderEmptyCallback = Widget Function(BuildContext context);
typedef DynamicDataBuilderErrorCallback = Widget Function(BuildContext context, DynamicDataError error);
typedef DynamicDataBuilderLoadingCallback = Widget Function(BuildContext context);
