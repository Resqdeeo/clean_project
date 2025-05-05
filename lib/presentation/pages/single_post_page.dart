import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../pages/posts_page.dart'; // Импорт страницы с пагинацией

class SinglePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Single Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            tooltip: "К списку постов",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostsPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: viewModel.isLoading
            ? CircularProgressIndicator()
            : viewModel.error != null
            ? Text("Error: ${viewModel.error}")
            : viewModel.post != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(viewModel.post!.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(viewModel.post!.body),
            ],
          ),
        )
            : Text("No Data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchPost(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}