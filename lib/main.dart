import 'package:flutter/material.dart';
import 'package:sharethought/route/route_generator.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/view/auth/login.dart';
import 'package:sharethought/view/home/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Kcolor.secondary,
        accentColor: Kcolor.white, 
        fontFamily: 'Arimo'
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: HomePage(),
    );
  }
}

class Comment {
  final String username;
  final String avatarUrl;
  final String comment;

  Comment({required this.username, required this.avatarUrl, required this.comment});
}

class FuckPage extends StatelessWidget {
  final List<Comment> comments = [
    Comment(username: 'John Doe', avatarUrl: 'https://example.com/avatar1.jpg', comment: 'This is a great post!'),
    Comment(username: 'Jane Smith', avatarUrl: 'https://example.com/avatar2.jpg', comment: 'Nice work!'),
    // Add more comments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Comment Section'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentCard(comment: comments[index]);
            },
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(comment.avatarUrl),
                ),
                SizedBox(width: 8.0),
                Text(
                  comment.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(comment.comment),
          ],
        ),
      ),
    );
  }
}

