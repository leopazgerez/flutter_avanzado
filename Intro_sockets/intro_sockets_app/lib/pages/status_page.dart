import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {

  emit(SocketService socketService, Map<String, dynamic> data) {
    socketService.socket.emit('new-event', (data));
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            socketService.serverStatus.name,
            style: const TextStyle(fontSize: 35),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            socketService.name,
            style: const TextStyle(fontSize: 35),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            socketService.message,
            style: const TextStyle(fontSize: 35),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => emit(socketService, {'Name': 'carnero'}),
      ),
    );
  }
}
