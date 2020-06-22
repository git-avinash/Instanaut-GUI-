import 'package:flutter/material.dart';

import '../screens/add_account_screen.dart';
import '../screens/add_work_screen.dart';
import '../screens/sessions_screen.dart';
import '../screens/help_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      AddWorkScreen(),
      SessionsScreen(),
    ];

    final _navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.library_add),
        title: Text('Add Work'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.loop),
        title: Text('Sessions'),
      ),
    ];

    final _navBar = BottomNavigationBar(
      items: _navItems,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Instanaut'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Add account'),
                    ],
                  ),
                ),
                value: 'AddAccount',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.help_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Help'),
                    ],
                  ),
                ),
                value: 'Help',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.bubble_chart),
                      SizedBox(
                        width: 10,
                      ),
                      Text('About'),
                    ],
                  ),
                ),
                value: 'About',
              )
            ],
            onChanged: (itemIdentifier) async {
              if (itemIdentifier == 'AddAccount') {
                await Navigator.of(context)
                    .pushNamed(AddAccountScreen.routeName);
              }
              if (itemIdentifier == 'Help') {
                Navigator.of(context).pushNamed(HelpScreen.routeName);
              }
              if (itemIdentifier == 'About') {
                showAboutDialog(
                  context: context,
                  applicationName: 'Instanaut',
                  applicationVersion: '1.0.0+1',
                  applicationLegalese:
                      'Copyright 2020 Avinash S Sah SPDX-License-Identifier: Apache-2.0',
                );
              }
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _navBar,
    );
  }
}
