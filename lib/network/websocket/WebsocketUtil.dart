

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketUtil{


  static WebSocketUtil? _instacne;

  IOWebSocketChannel? socketChannel;
  WebSocketSink? socketSink;

  void init(String url){
    socketChannel = IOWebSocketChannel.connect(url);
    socketSink = socketChannel?.sink;
  }

  static getInstance(){
    _instacne ??= WebSocketUtil();
    return _instacne;
  }

  IOWebSocketChannel channel(){
    return socketChannel!;
  }

  WebSocketSink sink(){
    return socketSink!;
  }

}