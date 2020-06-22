import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Image.asset('assets/images/cat.gif'),
                ),
                SizedBox(height: 5),
                Text('In app help is not available yet'),
                SizedBox(height: 5),
                Text('Find help here:'),
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
                  height: 5,
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
    );
  }
}
