import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DisconnectUseCase {
  final WebSocketRepository _webSocketRepository;

  DisconnectUseCase(this._webSocketRepository);

  Future<void> call() async {
    try {
      return await _webSocketRepository.disconnect();
    } catch (e) {
      //TODO

      rethrow;
    }
  }
}
