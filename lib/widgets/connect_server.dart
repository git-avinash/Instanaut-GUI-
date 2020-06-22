import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Image.asset('assets/images/InstanautBanner.png'),
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Linkify(
                    text: 'GitHub: https://github.com/git-avinash',
                    linkStyle: TextStyle(color: Colors.blue),
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Linkify(
                    text: 'Instagram: https://www.instagram.com/_avi.exe',
                    linkStyle: TextStyle(color: Colors.blue),
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
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
