import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  const tTodoModel = TodoModel.empty();

  final tMap = jsonDecode(fixture('todo.json')) as DataMap;
  
  test('should be a subclass of [TodoItem', () {
    expect(tTodoModel, isA<TodoItem>());
  });

  group('empty', () {
    test('should return a [TodoModel] with empty data', () {
      const result = TodoModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [TodoModel] with the correct data', () {
      final result = TodoModel.fromMap(tMap);
      expect(result, tTodoModel);
    });
  });

  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      final result = tTodoModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a [TodoListModel] with the new data', () async {
      final result = tTodoModel.copyWith(
        title: 'New Title',
      );

      expect(result.title, 'New Title');
    });
  });
}
