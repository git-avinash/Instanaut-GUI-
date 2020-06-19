import 'package:flutter/material.dart';

import '../widgets/add_account.dart';

class AddAccountScreen extends StatelessWidget {
  static const routeName = '/add-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AddAccount(),
    );
  }
}
