import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/features/history/domain/entity/historical_data.dart';
import 'package:ft/features/history/domain/use_case/get_historical_data_use_case.dart';
import 'package:injectable/injectable.dart';

part 'historical_data_event.dart';
part 'historical_data_state.dart';

@Injectable()
class HistoricalDataBloc
    extends Bloc<HistoricalDataEvent, HistoricalDataState> {
  final HistoricalDataRepositoryUseCase _historicalDataRepositoryUseCase;
  HistoricalDataBloc(this._historicalDataRepositoryUseCase)
    : super(HistoricalDataLoading()) {
    on<GetHistoricalDataEvent>((event, emit) async {
      try {
        // final list = await _historicalDataRepositoryUseCase(event.symbol);
        final list = await _historicalDataRepositoryUseCase('AAPL');
        emit(HistoricalDataWithData(list));
      } catch (e) {
        //todod
      }
    });
  }
}
