import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/data/mapper/ticker_mapper.dart';
import 'package:ft/features/ticker/data/mapper/ticker_list_mapper.dart';
import 'package:ft/features/ticker/data/response/ticker_response.dart';
import 'package:ft/features/ticker/data/response/web_socket_response.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([TickerMapper])
import 'ticker_list_mapper_test.mocks.dart';

void main() {
  late MockTickerMapper mockTickerMapper;
  late TickerListMapper tickerListMapper;

  setUp(() {
    mockTickerMapper = MockTickerMapper();
    tickerListMapper = TickerListMapper(mockTickerMapper);
  });

  group('TickerListMapper.fromJson', () {
    test('returns empty list if response.data is null', () {
      final response = WebSocketResponse(data: null);

      final result = tickerListMapper.fromJson(response);

      expect(result, isEmpty);
      verifyZeroInteractions(mockTickerMapper);
    });

    test('maps each JSON object to a TickerEntity', () {
      final dummyJson1 = TickerResponse(s: 'T1', p: 10.0);
      final dummyJson2 = TickerResponse(s: 'T3', p: 20.0);
      final response = WebSocketResponse(data: [dummyJson1, dummyJson2]);

      final tickerEntity1 = TickerEntity(s: 'T1', p: 10.0, t: 1.0);
      final tickerEntity2 = TickerEntity(s: 'T2', p: 20.0, t: 2.0);

      when(mockTickerMapper.fromJson(dummyJson1)).thenReturn(tickerEntity1);
      when(mockTickerMapper.fromJson(dummyJson2)).thenReturn(tickerEntity2);

      final result = tickerListMapper.fromJson(response);

      expect(result, equals([tickerEntity1, tickerEntity2]));
      verify(mockTickerMapper.fromJson(dummyJson1)).called(1);
      verify(mockTickerMapper.fromJson(dummyJson2)).called(1);
      verifyNoMoreInteractions(mockTickerMapper);
    });
  });
}
