import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/add_account_screen.dart';
import './screens/connect_server_screen.dart';
import './helpers/account_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AccountHandler>(
          create: (context) => AccountHandler(),
        ),
      ],
      child: Consumer<AccountHandler>(
        builder: (ctx, status, _) => MaterialApp(
          title: 'Instanaut',
          theme: ThemeData(
            primaryColor: Colors.deepPurple[900],
            accentColor: Colors.amber,
            backgroundColor: Colors.deepPurple[900],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Roboto',
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.amber,
              splashColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            textTheme: TextTheme(
              button: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // home: HomeScreen(),
          home: status.isConnected ? HomeScreen() : ConnectToServerScreen(),
          routes: {
            AddAccountScreen.routeName: (ctx) => AddAccountScreen(),
          },
        ),
      ),
    );
  }
}
