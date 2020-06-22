import 'package:flutter/material.dart';

import './client.dart';

class AccountHandler with ChangeNotifier {
  List<dynamic> _users = [];
  List<dynamic> _userSessionData = [];
  String _activeUser = '';
  bool _isConnectedToServer = false;
  bool _setDefault = true;
  String _ip;
  var _port;

  List<dynamic> get users {
    return [..._users];
  }

  bool get isConnected {
    return _isConnectedToServer;
  }

  List<dynamic> get userSessionData {
    return [..._userSessionData];
  }

  String get activeUser {
    return _activeUser;
  }

  void setDefaultUser() {
    if (_users.isEmpty) {
      _activeUser = '';
    }
    if (_users.isNotEmpty) {
      if (_setDefault) {
        _activeUser = _users[0];
        _setDefault = false;
      }
    }
  }

  void setActiveUser(String user) {
    _activeUser = user;
    notifyListeners();
  }

  Future<void> createAcc({
    @required String username,
    @required String password,
    @required BuildContext context,
  }) async {
    Map payload = {
      'command': 'createAccount',
      'username': username,
      'password': password
    };

    Map response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );
    if (response['status'] == 'failedToCreateAccount') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create account.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    if (response['status'] == 'accountCreated') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      _setDefault = true;
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future<void> connect({
    @required String ip,
    @required var port,
    @required BuildContext context,
  }) async {
    Map payload = {'command': 'connectionTest'};

    Map response = await request(
      requestJson: payload,
      ip: ip,
      port: port,
    );
    if (response['status'] == 'success') {
      _ip = ip;
      _port = port;
      _isConnectedToServer = true;
      notifyListeners();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to connect.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future<void> createSession({
    @required String username,
    @required BuildContext context,
    @required bool workingStatus,
    @required bool lkStatusHashtag,
    @required String hashtag,
    @required bool lkStatusComment,
    @required List comments,
    @required bool lkStatusLocation,
    @required String url,
    @required bool stStatusHashtag,
    @required bool stStatusLocation,
  }) async {
    Map payload = {
      'command': 'createSession',
      'username': username,
      'working_status': workingStatus,
      'lk_status_hashtag': lkStatusHashtag,
      'hashtag': hashtag,
      'lk_status_comment': lkStatusComment,
      'comments': comments,
      'lk_status_location': lkStatusLocation,
      'url': url,
      'st_status_hashtag': stStatusHashtag,
      'st_status_location': stStatusLocation,
    };

    Map response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );

    if (response['status'] == 'success') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Session created successfully!'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> fetchAllUsers() async {
    Map payload = {
      'command': 'fetchAllUsers',
    };
    Map<String, dynamic> response = (await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    ))
        .cast<String, dynamic>();
    if (response['user_data'].isNotEmpty) {
      List<dynamic> data = response['user_data'];
      print('PRINTING DATA: $data');
      _users = [];
      _users.addAll(data);
    }
    notifyListeners();
  }

  Future<void> fetchSessionData() async {
    Map payload = {
      'command': 'fetchSessionData',
      'username': _activeUser,
    };

    _userSessionData = [];

    Map<String, dynamic> response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );
    if (response['data'].isNotEmpty) {
      List<dynamic> data = response['data'];
      _userSessionData.addAll(data);
    } else {
      return;
    }
    notifyListeners();
  }

  Future<void> triggerSessionActivity({
    @required BuildContext context,
    @required String username,
    @required int workingStatus,
    @required String key,
  }) async {
    Map payload = {
      'command': 'triggerSessionActivity',
      'username': username,
      'key': key,
      'working_status': workingStatus,
    };
    Map response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );
    if (response['status'] == 'success') {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Session updated successfully'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update session.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> deleteAccount({
    @required BuildContext context,
    @required String username,
  }) async {
    Map payload = {
      'command': 'deleteAccount',
      'username': username,
    };
    Map response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );

    if (response['status'] == 'success') {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Account deleted successfully'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> deleteSession({
    @required BuildContext context,
    @required String sessionKey,
  }) async {
    Map payload = {
      'command': 'deleteSession',
      'sessionKey': sessionKey,
    };

    Map response = await request(
      requestJson: payload,
      ip: _ip,
      port: _port,
    );

    if (response['status'] == 'success') {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Session deleted successfully'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete session'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    notifyListeners();
  }
}
