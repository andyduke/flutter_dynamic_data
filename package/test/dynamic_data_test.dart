import 'package:flutter_test/flutter_test.dart';
import 'package:dynamic_data/dynamic_data.dart';

void main() {
  group('Empty Check', () {
    test('Null', () async {
      final data = DynamicData(futureBuilder: () async => null, autoLoad: false);
      await data.load();

      expect(data.isEmpty, isTrue);
    });

    test('String', () async {
      final data = DynamicData(futureBuilder: () async => '', autoLoad: false);
      await data.load();

      expect(data.isEmpty, isTrue);
    });

    test('String (not empty)', () async {
      final data = DynamicData(futureBuilder: () async => 'test', autoLoad: false);
      await data.load();

      expect(data.isEmpty, isFalse);
    });

    test('List', () async {
      final data = DynamicData(futureBuilder: () async => [], autoLoad: false);
      await data.load();

      expect(data.isEmpty, isTrue);
    });

    test('Map', () async {
      final data = DynamicData(futureBuilder: () async => {}, autoLoad: false);
      await data.load();

      expect(data.isEmpty, isTrue);
    });

    test('Set', () async {
      final data = DynamicData(futureBuilder: () async => <dynamic>{}, autoLoad: false);
      await data.load();

      expect(data.isEmpty, isTrue);
    });
  });
}
