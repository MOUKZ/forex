import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/use_cases/get_latest_ticker_data_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/get_stream_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/subscribe_use_case.dart';
import 'package:ft/features/ticker/domain/use_cases/unsubscribe_use_case.dart';
import 'package:ft/features/ticker/presentation/ui_model/presentation_ticker_entity.dart';
import 'package:injectable/injectable.dart';

part 'ticker_bloc_event.dart';
part 'ticker_bloc_state.dart';

@Injectable()
class TickerBloc extends Bloc<TickerBlocEvent, TickerBlocState> {
  final SubscribeUseCase _subscribeUseCase;
  final UnSubscribeUseCase _unSubscribeUseCase;
  final GetStreamUseCase _getStreamUseCase;
  final GetLatestTickerDataUseCase _getLatestTickerDataUseCase;

  StreamSubscription<List<TickerEntity>?>? _streamSubscription;

  TickerBloc(
    this._subscribeUseCase,
    this._unSubscribeUseCase,
    this._getStreamUseCase,
    this._getLatestTickerDataUseCase,
  ) : super(TickerBlocInitial()) {
    on<InitSubscription>(_onInitSubscription);
    on<CloseSubscription>(_onCloseSubscription);
    on<UpdateTickerEvent>(_onUpdateTickerEvent);
  }

  FutureOr<void> _onUpdateTickerEvent(UpdateTickerEvent event, emit) async {
    emit(UpdateTickerState(ticker: event.ticker));
  }

  FutureOr<void> _onInitSubscription(InitSubscription event, emit) async {
    try {
      _streamSubscription?.cancel();
      await _subscribeUseCase(event.symbol);
      final stream = await _getStreamUseCase();
      _streamSubscription = stream?.listen((wsEvent) {
        final latestItem = _getLatestTickerDataUseCase(
          wsEvent ?? [],
          event.symbol,
        );
        add(UpdateTickerEvent(latestItem));
      });
    } catch (e) {
      //TODO
    }
  }

  FutureOr<void> _onCloseSubscription(event, emit) async {
    try {
      await _unSubscribeUseCase(event.symbol);
    } catch (e) {
      //TODO
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamSubscription = null;

    return super.close();
  }
}
