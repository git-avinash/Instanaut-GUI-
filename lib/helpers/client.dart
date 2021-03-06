import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';

Socket _socket;
Map _response = {};

Future<Map> request({
  @required Map requestJson,
  @required String ip,
  @required var port,
}) async {
  try {
    _socket = await Socket.connect(
      ip,
      port,
      timeout: Duration(seconds: 15),
    );

    final _payload = jsonEncode(requestJson);
    String _msgLength = _payload.length.toString();
    int _header = 10 - _msgLength.length;
    String _finalMessage = _msgLength + (" " * _header) + _payload;
    print('[PAYLOAD] $_finalMessage');
    _socket.write(_finalMessage);
    final _responseReceive = await _socket.first;
    _response = await jsonDecode(utf8.decode(_responseReceive));
    print('[RESPONSE RECEIVED] $_response');
  } catch (error) {
    print(error);
  }
  return _response;
}
