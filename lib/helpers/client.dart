import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';

Map _response;

Future<Map> request({
  @required Map requestJson,
  @required String ip,
  @required var port,
}) async {
  Socket _socket;
  await Socket.connect(ip, port).then((Socket sock) {
    _socket = sock;
  }).then((_) {
    final _payload = jsonEncode(requestJson);
    final _msgLength = _payload.length.toString();
    final _headerCalc = _msgLength.length;
    final _header = 10 - _headerCalc;

    final _finalMessage = _msgLength + (" " * _header) + _payload;
    print('[PAYLOAD] $_finalMessage');
    _socket.write(_finalMessage);
    return _socket.first;
  }).then((data) {
    _response = jsonDecode(utf8.decode(data));
    print('[RESPONSE RECEIVED] $_response');
  }).catchError((error) {
    print(error);
  });
  return _response;
}
