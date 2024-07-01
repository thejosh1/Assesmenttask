import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/create_todo_item.dart';

import 'todo_repo.mock.test.dart';

void main() {
  late MockTodoRepo repo;
  late CreateTodoUsecase usecase;

  const tTodo = TodoItem.empty();

  setUp(() {
    repo = MockTodoRepo();
    usecase = CreateTodoUsecase(repo);
    registerFallbackValue(tTodo);
  });

  test('should return [CreateTodo] from [TodoItemRepo]', () async {
    when(
      () => repo.createTodo(todoItem: any(named: 'todoItem')),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      const CreateTodoUsecaseParams(todoItem: tTodo),
    );
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.createTodo(todoItem: tTodo),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
