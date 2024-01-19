import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class ToDo {
  final int id;
  final String text;

  ToDo({required this.id, required this.text});
}

class StatsData {
  final int total;
  final int pending;

  StatsData({required this.total, required this.pending});
}

class DemoDataModel {
  final List<ToDo> todos;
  final StatsData stats;

  DemoDataModel({required this.todos, required this.stats});
}

// ---

class FutureSuccessModelDataView extends StatefulWidget {
  const FutureSuccessModelDataView({super.key});

  @override
  State<FutureSuccessModelDataView> createState() => _FutureSuccessModelDataViewState();
}

class _FutureSuccessModelDataViewState extends State<FutureSuccessModelDataView> {
  late final DynamicData<DemoDataModel> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => DemoDataModel(
        todos: [
          ToDo(id: 1, text: 'ToDo 1'),
          ToDo(id: 2, text: 'ToDo 2'),
          ToDo(id: 3, text: 'ToDo ${DateTime.now()}'),
        ],
        stats: StatsData(total: 7, pending: 3),
      ),
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
      body: DynamicDataBuilder(
        data: _data,
        builder: (context, data) {
          return RefreshIndicator.adaptive(
            onRefresh: () => _data.reload(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stats', style: Theme.of(context).textTheme.displaySmall),
                  Text('All: ${data.stats.total}'),
                  Text('Pending: ${data.stats.pending}'),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      // physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.todos.length,
                      itemBuilder: (context, index) {
                        final item = data.todos[index];
                        return ListTile(
                          title: Text('#${item.id} ${item.text}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
