import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class FutureSuccessDataView extends StatefulWidget {
  const FutureSuccessDataView({super.key});

  @override
  State<FutureSuccessDataView> createState() => _FutureSuccessDataViewState();
}

class _FutureSuccessDataViewState extends State<FutureSuccessDataView> {
  late final DynamicData<Map<String, dynamic>> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => {
        'todos': [
          {'id': 1, 'name': 'ToDo 1'},
          {'id': 2, 'name': 'ToDo 2'},
          {'id': 3, 'name': 'ToDo ${DateTime.now()}'},
        ],
        'stats': {
          'all': 7,
          'pending': 3,
        },
      },
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
      body: DynamicDataBuilder<Map<String, dynamic>>(
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
                  Text('All: ${data['stats']['all']}'),
                  Text('Pending: ${data['stats']['pending']}'),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      // physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data['todos'].length,
                      itemBuilder: (context, index) {
                        final item = data['todos'][index];
                        return ListTile(
                          title: Text('#${item['id']} ${item['name']}'),
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
