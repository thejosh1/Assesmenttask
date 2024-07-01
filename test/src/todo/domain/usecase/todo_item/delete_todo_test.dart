import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/delete_todo.dart';

import 'todo_repo.mock.test.dart';

void main() {
  late MockTodoRepo repo;
  late DeleteTodoUseCase useCase;

  setUp(() {
    repo = MockTodoRepo();
    useCase = DeleteTodoUseCase(repo);
  });

  const tlistId = 'test list id';
  const tItemId = 'test item id';

  test('should return [DeleteTodo] from [Todo]', () async {
    when(
      () => repo.deleteTodo(
        listId: any(named: 'listId'),
        itemId: any(named: 'itemId'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await useCase(
      const DeleteTodoUseCaseParams(listId: tlistId, itemId: tItemId),
    );
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repo.deleteTodo(listId: tlistId, itemId: tItemId)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
