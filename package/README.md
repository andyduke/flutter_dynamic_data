# DynamicData

`DynamicData` helps manage the state *(loading, ready, empty, error)* of data loaded from various sources (such as API, database, etc).

The package provides a generic model with a state for loading data, as well as a widget for displaying in accordance with the state of the model.


## Quick Start

The model is created using the `DynamicData` class:
```dart
late final data = DynamicData<String>(
  futureBuilder: () async => 'Data',
);
```

When a model is created, it immediately begins loading data. If you use the `late` directive, then model creation and loading will occur the first time the variable is used.

If you need to manually control the start of loading data into the model, you must pass the `autoLoad: true` parameter to the model constructor and start the loading manually using the `load` method:
```dart
final data = DynamicData<String>(
  futureBuilder: () async => 'Data',
  autoLoad: true,
);
...
data.load();
```

Typically the `DynamicData` model is used in a `StatefulWidget`'s `State` object along with a `DynamicDataBuilder` widget that displays a different UI for each state of the model.

By default, the `DynamicDataBuilder` widget renders the UI for all states except the final state when the data is loaded, so you don't need to declare a UI for loading, error, or empty content states each time.

But you can at any time override the UI generation for any state using the `loadingBuilder`, `errorBuilder`, `emptyBuilder` parameters or set them above globally for the widget tree using the `DynamicDataDefaults` widget (see [Defaults](#defaults) for more details).

> The `DynamicData` model implements `ChangeNotifier`, so you can use it without `DynamicDataBuilder`, in conjunction with `ListenableBuilder`, although it is simply more convenient with `DynamicDataBuilder`:
<details>
  <summary>Using DynamicData with ListenableBuilder</summary>

```dart
ListenableBuilder(
  listenable: data,
  builder: (context, child) {
    return switch (data) {
      (DynamicData<String> d) when d.isEmpty => const Text('(empty data)'),
      (DynamicData<String> d) when d.isLoading => const CircularProgressIndicator(),
      (DynamicData<String> d) when d.hasError =>
        Text('Error: ${d.error}', style: const TextStyle(color: Colors.red)),
      (DynamicData<String> d) => Text('${d.data}'),
    };
  },
),
```
</details>

---

For a complete example of using `DynamicData` and `DynamicDataBuilder`, see below.

<details>
  <summary>Complete example</summary>

```dart
import 'package:flutter/material.dart';

// Simulate asynchronous API request
Future<String> simulatedApiRequest() async {
  return Future.delayed(const Duration(milliseconds: 300), () => 'API Response');
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DemoWidget(),
        ),
      ),
    );
  }
}

class DemoWidget extends StatefulWidget {
  const DemoWidget({super.key});

  @override
  State<DemoWidget> createState() => _DemoWidgetState();
}

class _DemoWidgetState extends State<DemoWidget> {

  // Define dynamic data
  late final _data = DynamicData<String>(
    futureBuilder: simulatedApiRequest,
  );

  @override
  void dispose() {
    // Dispose data
    _data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Render data
    return DynamicDataBuilder<String>(
      data: _data,
      builder: (context, data) => Text('Response: $data'),
    );
  }

}
```
</details>


## Typed data

`DynamicData` makes it possible to load data of any type, including class objects. Because `DynamicData` is generic; the type is specified when instantiating the `DynamicData` object:

```dart
// Loading string
final str = DynamicData<String>(...);

// Loading JSON Map
final json = DynamicData<Map<String, dynamic>>(...);

// Loading UserInfo object
final json = DynamicData<UserInfo>(...);
```


## Streaming data

By default, `DynamicData` expects a **Future** as the result of the data load callback. If you want to use a **Stream**, you need to use the named constructor `DynamicData.stream`:

```dart
final data = DynamicData<String>.stream(
  streamBuilder: () async => ...,
);
```

As long as nothing has arrived into the stream since the start of loading, it will be in the **loading** state; when data has arrived, it will switch to the **loaded** state. If the stream continues to receive data, `DynamicData` will notify its subscribers of the change and provide the latest relevant data from the stream and will remain in the **loaded** state. If any error occurs in any of the above steps, `DynamicData` will switch to the **error** state.


## Reloading data

If you need to reload previously loaded data into `DynamicData`, you can use its `reload()` method.

Here is an example of implementing data refresh using the pull-to-refresh pattern:

```dart
class RefreshDataExample extends StatefulWidget {
  const RefreshDataExample({super.key});

  @override
  State<RefreshDataExample> createState() => _RefreshDataExampleState();
}

class _RefreshDataExampleState extends State<RefreshDataExample> {
  late final DynamicData<int> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => Random().nextInt(10),
    ),
  );

  @override
  void dispose() {
    _data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicDataBuilder<int>(
        data: _data,
        builder: (context, data) {
          return RefreshIndicator.adaptive(
            onRefresh: () => _data.reload(),
            child: Text('Value: $data'),
          );
        },
      ),
    );
  }
}
```


## Defaults

Default state builders for `DynamicDataBuilder` can be set using `DynamicDataDefaults`, for example in the `builder` method of the `MaterialApp` class:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      builder: (context, child) => DynamicDataDefaults(
        emptyBuilder: (context) => const Center(
          child: Text('No data.'),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
```

`DynamicDataDefaults` gives you the ability to override the **loading** state builder *(displays `CircularProgressIndicator` by default)*, **error** state builder *(displays error text and stack trace by default)*, and **empty data** state builder *(displays nothing by default)*.
