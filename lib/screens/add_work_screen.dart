import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/account_handler.dart';

class AddWorkScreen extends StatefulWidget {
  @override
  _AddWorkScreenState createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isInit = true;
  bool _likeStatus = false;
  bool _hashTagStatus = false;
  String _hashTag = '';
  bool _commentStatus = false;
  List<String> _commentMsg = [];
  bool _urlStatus = false;
  String _url = '';
  bool _stHashTagStatus = false;
  bool _stLocationStatus = false;
  bool _massStrory = false;

  @override
  void didChangeDependencies() {
    _isLoading = true;
    if (_isInit) {
      Provider.of<AccountHandler>(context, listen: false)
          .fetchAllUsers()
          .then((_) {
        Provider.of<AccountHandler>(context, listen: false).setActiveUser();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _tryStartSession() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      final _user =
          Provider.of<AccountHandler>(context, listen: false).activeUser;
      FocusScope.of(context).unfocus();
      await Provider.of<AccountHandler>(context, listen: false).createSession(
        context: context,
        username: _user,
        workingStatus: true,
        lkStatusHashtag: _hashTagStatus,
        hashtag: _hashTag,
        lkStatusComment: _commentStatus,
        comments: _commentMsg,
        lkStatusLocation: _urlStatus,
        url: _url,
        stStatusHashtag: _stHashTagStatus,
        stStatusLocation: _stLocationStatus,
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
        elevation: 10,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mass Like Posts'),
                      Switch(
                        onChanged: _massStrory
                            ? null
                            : (bool value) {
                                setState(() {
                                  _likeStatus = value;
                                });
                              },
                        value: _likeStatus,
                      ),
                    ],
                  ),
                  if (_likeStatus)
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Target HashTag'),
                              Switch(
                                onChanged: _urlStatus
                                    ? null
                                    : (bool value) {
                                        setState(() {
                                          _hashTagStatus = value;
                                        });
                                      },
                                value: _hashTagStatus,
                              ),
                            ],
                          ),
                          if (_hashTagStatus)
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Hashtag',
                                    ),
                                    cursorColor: Theme.of(context).primaryColor,
                                    autocorrect: false,
                                    enableSuggestions: true,
                                    onSaved: (value) {
                                      _hashTag = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a Hashtag';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Enable Comments'),
                                      Switch(
                                        value: _commentStatus,
                                        onChanged: (value) {
                                          setState(() {
                                            _commentStatus = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (_commentStatus)
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Add comments seperated by , (comma)',
                                      ),
                                      autocorrect: false,
                                      enableSuggestions: true,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      onSaved: (value) {
                                        List comments = value.split(",");
                                        _commentMsg = comments;
                                      },
                                    ),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Target Location'),
                              Switch(
                                onChanged: _hashTagStatus
                                    ? null
                                    : (bool value) {
                                        setState(() {
                                          _urlStatus = value;
                                        });
                                      },
                                value: _urlStatus,
                              ),
                            ],
                          ),
                          if (_urlStatus)
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Location URL',
                                    ),
                                    cursorColor: Theme.of(context).primaryColor,
                                    autocorrect: false,
                                    enableSuggestions: true,
                                    onSaved: (value) {
                                      _url = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a Hashtag.';
                                      }
                                      if (!value.startsWith(
                                          'https://www.instagram.com/')) {
                                        return 'Please enter proper URL';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Enable Comments'),
                                      Switch(
                                        value: _commentStatus,
                                        onChanged: (value) {
                                          setState(() {
                                            _commentStatus = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (_commentStatus)
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Add comments seperated by , (comma)',
                                      ),
                                      autocorrect: false,
                                      enableSuggestions: true,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      onSaved: (value) {
                                        List comments = value.split(",");
                                        _commentMsg = comments;
                                      },
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('View Mass Story'),
                      Switch(
                        onChanged: _likeStatus
                            ? null
                            : (bool value) {
                                setState(() {
                                  _massStrory = value;
                                });
                              },
                        value: _massStrory,
                      ),
                    ],
                  ),
                  if (_massStrory)
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Target HashTag'),
                              Switch(
                                onChanged: (bool value) {
                                  setState(() {
                                    _stHashTagStatus = value;
                                  });
                                },
                                value: _stHashTagStatus,
                              ),
                            ],
                          ),
                          if (_stHashTagStatus)
                            Container(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Enter Hashtag'),
                                onSaved: (value) {
                                  _hashTag = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a Hashtag';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Target Location'),
                              Switch(
                                onChanged: (bool value) {
                                  setState(() {
                                    _stLocationStatus = value;
                                  });
                                },
                                value: _stLocationStatus,
                              ),
                            ],
                          ),
                          if (_stLocationStatus)
                            Container(
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Location URL'),
                                onSaved: (value) {
                                  _url = value;
                                },
                                validator: (value) {
                                  if (!value.startsWith(
                                      'https://www.instagram.com/')) {
                                    return 'Please enter proper URL';
                                  }
                                  if (value.isEmpty) {
                                    return 'Please enter a URL';
                                  }
                                  return null;
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: RaisedButton(
                          child: Text('Start Session'),
                          onPressed: _tryStartSession,
                        ),
                      )
                    ],
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
