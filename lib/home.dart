import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:utility/model/kecamatan.model.dart';

import 'repository/socket.repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  IO.Socket? socket;
  SocketRepository _socketRepository = new SocketRepository();
  KecamatanModel _kecamatanModel = new KecamatanModel();

  final _message = TextEditingController();
  List dataList = [];

  initSocket() {
    socket = IO.io('http://10.0.2.2:8081/', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
  }

  void initState() {
    super.initState();
    initSocket();
    // _socketIo();
    _readMessage();
    // print('test');
  }

  @override
  void dispose() {
    socket!.dispose();
    super.dispose();
  }

  _readMessage() async {
    socket!.on('connect', (_) {
      print('Connected to the server');
    });
    socket!.on('message', (data) {
      _kecamatanModel = KecamatanModel.fromJson(data);
      setState(() {});
    });
  }

  sendMessage() async {
    var data = await _socketRepository.sendMessage(_message.text);
  }

  @override
  Widget build(BuildContext context) {
    print(dataList);
    return Container(
      child: Center(
          child: Column(
        children: [
          //   TextFormField(
          //     controller: _message,
          //   ),
          //   TextButton(
          //     onPressed: () => sendMessage(),
          //     child: Text('Send Message'),
          //   ),
          //   _kecamatanModel.data != null
          //       ? ListView.builder(
          //           shrinkWrap: true,
          //           physics: ClampingScrollPhysics(),
          //           itemCount: _kecamatanModel.data!.length,
          //           itemBuilder: (context, index) {
          //             var newData = _kecamatanModel.data![index];
          //             print(_kecamatanModel.data!.length);
          //             return ListTile(
          //               title: Column(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Text('${newData.id}'),
          //                     Text('${newData.name}')
          //                   ]),
          //             );
          //           })
          //       : Container()
        ],
      )),
    );
  }
}
