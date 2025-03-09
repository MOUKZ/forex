import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/presentation/ui_model/presentation_ticker_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetLatestTickerDataUseCase {
  PresentationTickerEntity? call(List<TickerEntity> entries, String symbol) {
    TickerEntity? latest;
    TickerEntity? previous;

    for (final entry in entries) {
      if (entry.s != symbol) continue;

      // Use double comparisons for timestamps.
      if (latest == null ||
          (entry.t != null && latest.t != null && entry.t! > latest.t!)) {
        if (latest != null) {
          previous = latest;
        }
        latest = entry;
      } else if (previous == null ||
          (entry.t != null &&
              previous.t != null &&
              entry.t! > previous.t! &&
              entry.t! < latest.t!)) {
        previous = entry;
      }
    }

    if (latest == null) return null;

    double? change;
    double? changePercent;

    if (previous != null &&
        previous.p != null &&
        previous.p! != 0 &&
        latest.p != null) {
      change = latest.p! - previous.p!;
      changePercent = (change / previous.p!) * 100;
    }

    return PresentationTickerEntity(
      change: change ?? 0,
      percentChange: changePercent ?? 0,
      currentPrice: latest.p ?? 0,
    );
  }
}
