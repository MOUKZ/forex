import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/forex_pairs/domain/use_cases/get_forex_pairs_use_case.dart';
import 'package:injectable/injectable.dart';

part 'forex_pairs_event.dart';
part 'forex_pairs_state.dart';

@Injectable()
class ForexPairsBloc extends Bloc<ForexPairsEvent, ForexPairsState> {
  final GetForexPairsUseCase getForexPairsUseCase;

  ForexPairsBloc(this.getForexPairsUseCase) : super(ForexPairsLoading()) {
    on<LoadForexPairsEvent>(_onLoadForexPairsEvent);
  }

  FutureOr<void> _onLoadForexPairsEvent(LoadForexPairsEvent event, emit) async {
    try {
      emit(ForexPairsLoading());
      final pairs = await getForexPairsUseCase();
      emit(ForexPairsWithData(pairs));
    } catch (e) {
      emit(ForexPairsFailed());
    }
  }
}
