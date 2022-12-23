import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example_websocket/get_cryptocurrency.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  var channel =
      IOWebSocketChannel.connect("wss://ws.coincap.io/prices?assets=ALL");

  runApp(
    MyApp(
      channel:
          IOWebSocketChannel.connect("wss://ws.coincap.io/prices?assets=ALL"),
    ),
  );

  channel.stream.listen(
    (event) {
      if (event != null) {
        final data = jsonDecode(event as String) as Map<String, dynamic>;
        // if(data['bitcoin'] != null)
        print(data['bitcoin']);
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.channel});
  final WebSocketChannel channel;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var respons = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Example WebSocket"),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) =>
                Text(snapshot.hasData ? '${snapshot.data}' : ''),
          ),
        ),
      ),
    );
  }
}
