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

// Map _response;

// Future<Map> request({
//   @required Map requestJson,
//   @required String ip,
//   @required var port,
// }) async {
//   Socket _socket;
//   await Socket.connect(
//     ip,
//     port,
//     timeout: Duration(seconds: 15),
//   ).then((Socket sock) {
//     _socket = sock;
//   }).then((_) {
//     final _payload = jsonEncode(requestJson);
//     final _msgLength = _payload.length.toString();
//     final _headerCalc = _msgLength.length;
//     final _header = 10 - _headerCalc;

//     final _finalMessage = _msgLength + (" " * _header) + _payload;
//     print('[PAYLOAD] $_finalMessage');
//     _socket.write(_finalMessage);
//     return _socket.first;
//   }).then((data) {
//     _response = jsonDecode(utf8.decode(data));
//     print('[RESPONSE RECEIVED] $_response');
//   }).catchError((error) {
//     print(error);
//   });
//   return _response;
// }
