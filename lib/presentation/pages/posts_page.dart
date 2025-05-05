import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: Consumer<PostViewModel>(
        builder: (context, viewModel, child) {
          // Показываем индикатор загрузки, если данные еще не загружены
          if (viewModel.isLoading && viewModel.posts.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // Создаем ListView с динамическим числом элементов
          return ListView.builder(
            itemCount: viewModel.posts.length + 1, // +1 для индикатора загрузки
            itemBuilder: (context, index) {
              // Когда достигаем последнего элемента, загружаем новые посты
              if (index == viewModel.posts.length) {
                if (!viewModel.isEndReached) {
                  // Если данные не закончились, подгружаем новые
                  viewModel.loadPosts();
                  return Center(child: CircularProgressIndicator()); // Индикатор загрузки
                }
                return SizedBox.shrink(); // Если достигнут конец — ничего не показываем
              }

              final post = viewModel.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
      ),
    );
  }
}


