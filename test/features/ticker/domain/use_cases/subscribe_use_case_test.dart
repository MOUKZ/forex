import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:ft/features/ticker/domain/use_cases/subscribe_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([WebSocketRepository])
import 'subscribe_use_case_test.mocks.dart';

void main() {
  late SubscribeUseCase subscribeUseCase;
  late MockWebSocketRepository mockWebSocketRepository;

  setUp(() {
    mockWebSocketRepository = MockWebSocketRepository();
    subscribeUseCase = SubscribeUseCase(mockWebSocketRepository);
  });

  group('SubscribeUseCase', () {
    test('calls subscribe on repository with the correct symbol', () async {
      const symbol = 'AAPL';
      when(
        mockWebSocketRepository.subscribe(symbol),
      ).thenAnswer((_) async => Future.value());

      await subscribeUseCase.call(symbol);

      verify(mockWebSocketRepository.subscribe(symbol)).called(1);
      verifyNoMoreInteractions(mockWebSocketRepository);
    });

    test(
      'rethrows exception when repository.subscribe throws an exception',
      () async {
        const symbol = 'AAPL';
        final exception = Exception('Subscribe failed');
        when(mockWebSocketRepository.subscribe(symbol)).thenThrow(exception);

        expect(
          () async => await subscribeUseCase.call(symbol),
          throwsA(exception),
        );
        verify(mockWebSocketRepository.subscribe(symbol)).called(1);
        verifyNoMoreInteractions(mockWebSocketRepository);
      },
    );
  });
}
