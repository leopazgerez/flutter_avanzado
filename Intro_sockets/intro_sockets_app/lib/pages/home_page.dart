import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../models/band_model.dart';
import '../services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = <BandModel>[];
  SocketService? socket;

  @override
  void initState() {
    super.initState();
    socket = Provider.of<SocketService>(context, listen: false);
    socket?.socket.on('active-bands', _handleActiveBands);
  }

  _emit(String channel, BandModel band) {
    socket?.socket.emit(channel, (band.toMap()));
  }

  _handleActiveBands(dynamic data) {
    if (data != null) {
      bands = (data as List).map((e) => BandModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  Map<String, double> dataMap() {
    Map<String, double> result = {};
    for (var element in bands) {
      result.putIfAbsent(element.name!, () => element.votes!.toDouble());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: socket?.appBarColor,
        title: Text(socket?.serverStatus.name ?? ''),
      ),
      body: Visibility(
        visible: bands.isNotEmpty,
        replacement: const Center(
          child: Text(
            ' No hay bandas crack',
            style: TextStyle(fontSize: 35),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: PieChart(
                dataMap: dataMap(),
                chartType: ChartType.ring,
                baseChartColor: Colors.grey[300]!,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, index) {
                  final band = bands[index];
                  return bandTile(band, () => _emit('vote-band', band));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: addNewBand, child: Icon(Icons.add)),
    );
  }

  Widget bandTile(BandModel band, Function onTap) {
    return Dismissible(
      key: Key(band.id!),
      onDismissed: (direction) => deleteBand(band),
      child: ListTile(
        title: Text(band.name ?? ''),
        leading: CircleAvatar(
          child: Text(
            (band.name ?? '').substring(0, 2),
          ),
        ),
        trailing: Text(band.votes.toString()),
        onTap: () => onTap.call(),
      ),
    );
  }

  addBandToList(String band) {
    if (band.length > 1) {
      final ob = BandModel(name: band);
      _emit('add-band', ob);
      setState(() {});
    }
  }

  deleteBand(BandModel band) {
    _emit('delete-band', band);
  }

  addNewBand() {
    TextEditingController textController = TextEditingController();
    if (Platform.isAndroid) {
      return _showDialog(textController);
    } else {
      return _showCupertinoDialog(textController);
    }
  }

  _showCupertinoDialog(TextEditingController textController) {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New Band'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () {
                addBandToList(textController.text);
              },
            ),
          ],
        );
      },
    );
  }

  _showDialog(TextEditingController textController) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('New Band'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text('Add'),
              onPressed: () {
                addBandToList(textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
