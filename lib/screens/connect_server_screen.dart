import 'package:flutter/material.dart';

import '../widgets/connect_server.dart';

class ConnectToServerScreen extends StatelessWidget {
  static const routeName = '/connect-server-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ConnectToServer(),
    );
  }
}