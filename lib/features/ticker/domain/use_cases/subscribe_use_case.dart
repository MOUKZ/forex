import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscribeUseCase {
  final WebSocketRepository _webSocketRepository;

  SubscribeUseCase(this._webSocketRepository);

  Future<void> call(String symbol) async {
    try {
      await _webSocketRepository.subscribe(symbol);
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
