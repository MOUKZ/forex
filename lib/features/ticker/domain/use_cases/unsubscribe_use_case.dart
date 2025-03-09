import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UnSubscribeUseCase {
  final WebSocketRepository _webSocketRepository;

  UnSubscribeUseCase(this._webSocketRepository);

  Future<void> call(String symbol) async {
    try {
      await _webSocketRepository.unSubscribe(symbol);
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
