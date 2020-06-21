import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/account_handler.dart';

class SessionsScreen extends StatefulWidget {
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AccountHandler>(context)
          .fetchSessionData(context: context)
          .then((_) {
        setState(() {
          _isLoading = false;
          _isInit = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountHandler>(
      builder: (ctx, data, _) => ListView.builder(
        itemCount: data.userSessionData.length,
        itemBuilder: (ctx, index) => Card(
          elevation: 10,
          child: Dismissible(
            key: Key(data.userSessionData[index]['key']),
            child: Container(
              child: ListTile(
                title: Text('Session ${index + 1}'),
                subtitle: Container(
                  child: Column(
                    children: [
                      Text(
                        'Target Hashtag: ${data.userSessionData[index]['hashtag']}',
                      ),
                      Text(
                        'Comments: ${data.userSessionData[index]['comments'].toString()}',
                      ),
                      Text(
                        'Target Location: ${data.userSessionData[index]['url']}',
                      ),
                      Text(
                        'Target Location: ${data.userSessionData[index]['url']}',
                      ),
                    ],
                  ),
                ),
                trailing: Switch(
                  value: data.userSessionData[index]['working_status'] == 1
                      ? true
                      : false,
                  onChanged: (_) async {
                    await data.triggerSessionActivity(
                      context: context,
                      username: data.activeUser,
                      workingStatus:
                          data.userSessionData[index]['working_status'] == 1
                              ? 0
                              : 1,
                      key: data.userSessionData[index]['key'],
                    );
                    await data.fetchSessionData(context: context);
                  },
                ),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd ||
                  direction == DismissDirection.endToStart) {
                data.deleteSession(
                  context: context,
                  sessionKey: data.userSessionData[index]['key'],
                );
              }
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to delete this Session?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("DELETE")),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("CANCEL"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
