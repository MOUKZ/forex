import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:ft/features/ticker/domain/use_cases/get_stream_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([WebSocketRepository])
import 'get_stream_use_case_test.mocks.dart';

void main() {
  late MockWebSocketRepository mockWebSocketRepository;
  late GetStreamUseCase useCase;

  setUp(() {
    mockWebSocketRepository = MockWebSocketRepository();
    useCase = GetStreamUseCase(mockWebSocketRepository);
  });

  group('GetStreamUseCase', () {
    test('should return stream from repository', () async {
      final tickerList = <TickerEntity>[
        TickerEntity(p: 100.0, s: 'AAPL', t: 12345.0, v: 1000),
      ];

      final dummyStream = Stream<List<TickerEntity>>.value(tickerList);
      when(
        mockWebSocketRepository.getStream(),
      ).thenAnswer((_) async => dummyStream);

      final resultStream = await useCase.call();

      expect(resultStream, isNotNull);
      final emittedList = await resultStream!.first;
      expect(emittedList, equals(tickerList));
      verify(mockWebSocketRepository.getStream()).called(1);
    });

    test('should rethrow exception when repository.getStream throws', () async {
      final exception = Exception('Test error');
      when(mockWebSocketRepository.getStream()).thenThrow(exception);

      expect(() async => await useCase.call(), throwsA(exception));
      verify(mockWebSocketRepository.getStream()).called(1);
    });
  });
}
