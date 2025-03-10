import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:ft/features/ticker/domain/use_cases/disconnect_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([WebSocketRepository])
import 'disconnect_use_case_test.mocks.dart';

void main() {
  late DisconnectUseCase useCase;
  late MockWebSocketRepository mockWebSocketRepository;

  setUp(() {
    mockWebSocketRepository = MockWebSocketRepository();
    useCase = DisconnectUseCase(mockWebSocketRepository);
  });

  test('should call disconnect on repository and complete normally', () async {
    when(mockWebSocketRepository.disconnect()).thenAnswer((_) async {});

    await useCase.call();

    verify(mockWebSocketRepository.disconnect()).called(1);
  });

  test(
    'should rethrow exception when repository.disconnect throws an exception',
    () async {
      final exception = Exception('Disconnect failed');
      when(mockWebSocketRepository.disconnect()).thenThrow(exception);

      expect(() async => await useCase.call(), throwsA(exception));
      verify(mockWebSocketRepository.disconnect()).called(1);
    },
  );
}
