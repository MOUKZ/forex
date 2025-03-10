// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@singleton
class WebSocketDataSource {
  final _key = 'cv6uripr01qsq4644de0cv6uripr01qsq4644deg';

  static final WebSocketDataSource _instance = WebSocketDataSource._internal();

  factory WebSocketDataSource() {
    return _instance;
  }

  WebSocketDataSource._internal();

  WebSocketChannel? _channel;

  Stream? _stream;

  /// Connects to the WebSocket server if not already connected.
  Future<void> connect() async {
    final url = 'wss://ws.finnhub.io?token=$_key';
    if (_channel == null) {
      _channel = IOWebSocketChannel.connect(Uri.parse(url));
      _stream = _channel!.stream.asBroadcastStream();
      print('Connected to WebSocket at $url');
    }
  }

  Future<Stream<dynamic>?> getStream() async {
    await connect();
    return _stream;
  }

  Future<void> subscribe(String symbol) async {
    await connect();

    if (_channel != null) {
      final message = jsonEncode({'type': 'subscribe', 'symbol': symbol});
      _channel!.sink.add(message);
      print('Sent: $message');
    } else {
      throw UnKnownException();
    }
  }

  Future<void> unSubscribe(String symbol) async {
    await connect();

    if (_channel != null) {
      final message = jsonEncode({'type': 'unsubscribe', 'symbol': symbol});
      _channel!.sink.add(message);
      print('Sent: $message');
    } else {
      throw UnKnownException();
    }
  }

  /// Closes the WebSocket connection.
  Future<void> close() async {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
      _stream = null;
      print('WebSocket connection closed');
    }
  }
}
