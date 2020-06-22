import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/account_handler.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _username = '';
  String _password = '';

  Future<void> _tryCreateAcc() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      await Provider.of<AccountHandler>(context, listen: false).createAcc(
        username: _username,
        password: _password,
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
                      labelText: 'Instagram Username',
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      _username = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid username.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    cursorColor: Theme.of(context).primaryColor,
                    onSaved: (value) {
                      _password = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid password';
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
                      onPressed: _tryCreateAcc,
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
