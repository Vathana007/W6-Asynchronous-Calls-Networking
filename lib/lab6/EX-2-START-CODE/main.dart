import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_week6/lab6/EX-2-START-CODE/repository/http_posts_repository.dart';
import 'package:lab_week6/lab6/EX-2-START-CODE/repository/post_repository.dart';
import 'package:lab_week6/lab6/EX-2-START-CODE/ui/providers/post_provider.dart';
import 'package:lab_week6/lab6/EX-2-START-CODE/ui/screens/post_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1- Create the repository instance
  PostRepository postRepo = HttpPostsRepository();

  // 2 - Run the app
  runApp(MyApp(postRepo: postRepo));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepo;

  const MyApp({super.key, required this.postRepo});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostProvider(repository: postRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Post Fetching App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const PostScreen(),
      ),
    );
  }
}
