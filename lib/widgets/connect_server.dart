import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/account_handler.dart';

class ConnectToServer extends StatefulWidget {
  @override
  _ConnectToServerState createState() => _ConnectToServerState();
}

class _ConnectToServerState extends State<ConnectToServer> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _ip = '';
  int _port;

  Future<void> _tryConnect() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      await Provider.of<AccountHandler>(context, listen: false).connect(
        ip: _ip,
        port: _port,
        context: context,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'IP Address',
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      _ip = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid IP Address.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Port number',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      String portNo = value.trim();
                      _port = int.parse(portNo);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid port.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  if (_isLoading)
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: CircularProgressIndicator(),
                    ),
                  if (!_isLoading)
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      child: Text('Login'),
                      onPressed: _tryConnect,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
