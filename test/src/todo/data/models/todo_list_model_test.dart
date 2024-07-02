import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  const tTodoListModel = TodoListModel.empty();

  final tMap = jsonDecode(fixture('todo_list.json')) as DataMap;
  tMap['items'] = <TodoItem>[const TodoItem.empty()];

  test('should be a subclass of [TodoList', () {
    expect(tTodoListModel, isA<TodoList>());
  });

  group('empty', () {
    test('should return a [TodoListModel] with empty data', () {
      const result = TodoListModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [TodoListModel] with the correct data', () {
      final result = TodoListModel.fromMap(tMap);
      expect(result, tTodoListModel);
    });
  });

  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      final result = tTodoListModel.toMap()..remove('items');

      final map = DataMap.from(tMap)..remove('items');
      expect(result, equals(map));
    });
  });

  group('copyWith', () {
    test('should return a [TodoListModel] with the new data', () async {
      final result = tTodoListModel.copyWith(
        title: 'New Title',
      );

      expect(result.title, 'New Title');
    });
  });
}
