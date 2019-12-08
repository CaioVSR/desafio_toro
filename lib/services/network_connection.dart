import 'dart:async';
import 'dart:convert';

import 'package:desafio_toro/services/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketConnection {
  static Future fetchData({@required BuildContext context}) async {
    try {
      WebSocketChannel channel = IOWebSocketChannel.connect("ws://localhost:8080/quotes");
      channel.stream.listen((onData) {
        Map decodedData = jsonDecode(onData);
        Provider.of<StockProvider>(context).addQuote(decodedData);
      }, onError: (error) async {
        channel.sink.close();
        await Future.delayed(Duration(seconds: 2), () => SocketConnection.fetchData(context: context));
      });
    } catch (e) {
      await Future.delayed(Duration(seconds: 2), () => SocketConnection.fetchData(context: context));
    }
  }
}
