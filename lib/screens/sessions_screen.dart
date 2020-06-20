import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/account_handler.dart';

class SessionsScreen extends StatefulWidget {
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

// {data: [{key: TOKIZ5Z, working_status: 1, lk_status_hashtag: 1, hashtag: art, lk_status_comment: 0,
// comments: [], lk_status_location: 0, url: , st_status_hashtag: 0, st_status_location: 0},
// {key: HOHB7W1, working_status: 1, lk_status_hashtag: 1, hashtag: blender, lk_status_comment: 1,
// comments: ['wow!', ' awesome dude!'], lk_status_location: 0, url: , st_status_hashtag: 0, st_status_location: 0}]}

class _SessionsScreenState extends State<SessionsScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  bool convertTF(int value) {
    bool _converted;
    if (value == 0) {
      _converted = false;
    }
    if (value == 1) {
      _converted = true;
    }
    return _converted;
  }

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
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<AccountHandler>(
        builder: (ctx, data, _) => Column(
          children: [
            ListView.builder(
              itemCount: data.userSessionData.length,
              itemBuilder: (ctx, index) => Container(
                child: Column(
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
