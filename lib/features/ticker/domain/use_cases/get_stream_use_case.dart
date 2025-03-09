import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetStreamUseCase {
  final WebSocketRepository _webSocketRepository;

  GetStreamUseCase(this._webSocketRepository);

  Future<Stream<List<TickerEntity>?>?> call() async {
    try {
      final response = await _webSocketRepository.getStream();
      return response;
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
