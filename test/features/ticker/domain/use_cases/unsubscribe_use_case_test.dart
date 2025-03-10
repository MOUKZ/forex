import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:ft/features/ticker/domain/use_cases/unsubscribe_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([WebSocketRepository])
import 'unsubscribe_use_case_test.mocks.dart';

void main() {
  late UnSubscribeUseCase useCase;
  late MockWebSocketRepository mockWebSocketRepository;

  setUp(() {
    mockWebSocketRepository = MockWebSocketRepository();
    useCase = UnSubscribeUseCase(mockWebSocketRepository);
  });

  group('UnSubscribeUseCase', () {
    test('calls unSubscribe on repository with the correct symbol', () async {
      const symbol = 'AAPL';
      when(
        mockWebSocketRepository.unSubscribe(symbol),
      ).thenAnswer((_) async => Future.value());

      await useCase.call(symbol);

      verify(mockWebSocketRepository.unSubscribe(symbol)).called(1);
      verifyNoMoreInteractions(mockWebSocketRepository);
    });

    test(
      'rethrows exception when repository.unSubscribe throws an exception',
      () async {
        const symbol = 'AAPL';
        final exception = Exception('Unsubscribe failed');
        when(mockWebSocketRepository.unSubscribe(symbol)).thenThrow(exception);

        expect(() async => await useCase.call(symbol), throwsA(exception));
        verify(mockWebSocketRepository.unSubscribe(symbol)).called(1);
        verifyNoMoreInteractions(mockWebSocketRepository);
      },
    );
  });
}
