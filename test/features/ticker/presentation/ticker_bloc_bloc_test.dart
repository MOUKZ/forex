import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/use_cases/get_latest_ticker_data_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/get_stream_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/subscribe_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/unsubscribe_use_case.dart';
import 'package:ft/features/ticker/presentation/bloc/ticker_bloc_bloc.dart';
import 'package:ft/features/ticker/presentation/ui_model/presentation_ticker_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  SubscribeUseCase,
  UnSubscribeUseCase,
  GetStreamUseCase,
  GetLatestTickerDataUseCase,
])
import 'ticker_bloc_bloc_test.mocks.dart';

void main() {
  late MockSubscribeUseCase mockSubscribeUseCase;
  late MockUnSubscribeUseCase mockUnSubscribeUseCase;
  late MockGetStreamUseCase mockGetStreamUseCase;
  late MockGetLatestTickerDataUseCase mockGetLatestTickerDataUseCase;
  late TickerBloc tickerBloc;

  final dummyTickerEntity = TickerEntity(
    p: 100.0,
    s: 'AAPL',
    t: 12345.0,
    v: 100,
  );
  final dummyPresentationTickerEntity = PresentationTickerEntity(
    change: 5.0,
    percentChange: 5.0,
    currentPrice: 105.0,
  );

  setUp(() {
    mockSubscribeUseCase = MockSubscribeUseCase();
    mockUnSubscribeUseCase = MockUnSubscribeUseCase();
    mockGetStreamUseCase = MockGetStreamUseCase();
    mockGetLatestTickerDataUseCase = MockGetLatestTickerDataUseCase();
    tickerBloc = TickerBloc(
      mockSubscribeUseCase,
      mockUnSubscribeUseCase,
      mockGetStreamUseCase,
      mockGetLatestTickerDataUseCase,
    );
  });

  tearDown(() async {
    await tickerBloc.close();
  });

  group('TickerBloc', () {
    blocTest<TickerBloc, TickerBlocState>(
      'emits UpdateTickerState when InitSubscription succeeds',
      build: () {
        when(
          mockSubscribeUseCase.call('AAPL'),
        ).thenAnswer((_) async => Future.value());

        when(mockGetStreamUseCase.call()).thenAnswer(
          (_) async => Stream<List<TickerEntity>?>.value([dummyTickerEntity]),
        );

        when(
          mockGetLatestTickerDataUseCase.call(any, 'AAPL'),
        ).thenReturn(dummyPresentationTickerEntity);
        return tickerBloc;
      },
      act: (bloc) async {
        bloc.add(InitSubscription('AAPL'));

        await Future.delayed(Duration.zero);
      },
      expect:
          () => [
            isA<UpdateTickerState>().having(
              (state) => state.ticker,
              'ticker',
              dummyPresentationTickerEntity,
            ),
          ],
      verify: (_) {
        verify(mockSubscribeUseCase.call('AAPL')).called(1);
        verify(mockGetStreamUseCase.call()).called(1);
        verify(mockGetLatestTickerDataUseCase.call(any, 'AAPL')).called(1);
      },
    );

    blocTest<TickerBloc, TickerBlocState>(
      'emits TickerErrorState when InitSubscription fails (subscribe use case throws)',
      build: () {
        when(
          mockSubscribeUseCase.call('AAPL'),
        ).thenThrow(Exception('subscribe error'));
        return tickerBloc;
      },
      act: (bloc) async {
        bloc.add(InitSubscription('AAPL'));
        await Future.delayed(Duration.zero);
      },
      expect: () => [isA<TickerErrorState>()],
      verify: (_) {
        verify(mockSubscribeUseCase.call('AAPL')).called(1);
      },
    );

    blocTest<TickerBloc, TickerBlocState>(
      'emits TickerErrorState when unSubscribe fails during CloseSubscription',
      build: () {
        when(
          mockUnSubscribeUseCase.call('AAPL'),
        ).thenThrow(Exception('unsubscribe error'));
        return tickerBloc;
      },
      act: (bloc) async {
        bloc.add(CloseSubscription('AAPL'));
        await Future.delayed(Duration.zero);
      },
      expect: () => [isA<TickerErrorState>()],
      verify: (_) {
        verify(mockUnSubscribeUseCase.call('AAPL')).called(1);
      },
    );

    blocTest<TickerBloc, TickerBlocState>(
      'emits TickerErrorState when AddErrorEvent is added',
      build: () => tickerBloc,
      act: (bloc) async {
        bloc.add(AddErrorEvent());
        await Future.delayed(Duration.zero);
      },
      expect: () => [isA<TickerErrorState>()],
    );

    blocTest<TickerBloc, TickerBlocState>(
      'emits UpdateTickerState when UpdateTickerEvent is added directly',
      build: () => tickerBloc,
      act: (bloc) async {
        bloc.add(UpdateTickerEvent(dummyPresentationTickerEntity));
        await Future.delayed(Duration.zero);
      },
      expect:
          () => [
            isA<UpdateTickerState>().having(
              (state) => state.ticker,
              'ticker',
              dummyPresentationTickerEntity,
            ),
          ],
    );
  });
}
