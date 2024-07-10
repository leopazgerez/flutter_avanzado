import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  late io.Socket _socket;
  Color _appBarColor = Colors.orange;

  String _message = '';
  String _name = '';

  SocketService() {
    _initConfig();
  }

  ServerStatus get serverStatus => _serverStatus;

  String get message => _message;

  String get name => _name;
  Color get appBarColor => _appBarColor;

  io.Socket get socket => _socket;

  void _initConfig() {
    //dart client

    _socket = io.io(
        // TODO:change base on server
        'https://flutter-socket-87356b75894c.herokuapp.com/',
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    _socket.connect();
    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      _appBarColor = Colors.green;
      notifyListeners();
    });
    // socket.onDisconnect((_) => debugPrint('disconnect'));
    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      _appBarColor = Colors.red;
      notifyListeners();
    });

    _socket.on('new-event', (payload) {
      log(payload.toString());
      _message = payload['mensaje'];
      _name = payload['nombre'];
      notifyListeners();
    });
  }
}
