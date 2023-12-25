import 'package:flutter/material.dart';

class UserInboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        foregroundColor: Colors.black, // Warna teks pada AppBar
        title: Text('Inbox'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: Text('New Message'),
            subtitle: Text('From: John Doe'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Implementasi aksi ketika pesan baru ditekan
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('New Message'),
                    content: Text('This is a new message from John Doe.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Another Message'),
            subtitle: Text('From: Jane Doe'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Implementasi aksi ketika pesan lain ditekan
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Another Message'),
                    content: Text('This is another message from Jane Doe.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
