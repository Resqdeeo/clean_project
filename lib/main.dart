import 'package:clean_project/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'data/networks/api_service.dart';
import 'data/repositories_impl/post_repository_impl.dart';
import 'domain/usecases/get_single_post_usecase.dart';
import 'domain/usecases/get_posts_usecase.dart';
import 'presentation/pages/single_post_page.dart';
import 'presentation/viewmodels/post_viewmodel.dart';

void main() {
  final dio = Dio();
  final apiService = ApiService(dio);
  final repository = PostRepositoryImpl(apiService);

  final getSinglePostUseCase = GetSinglePostUseCase(repository);
  final getPostsUseCase = GetPostsUseCase(repository);

  final postViewModel = PostViewModel(getSinglePostUseCase, getPostsUseCase);

  runApp(MyApp(viewModel: postViewModel));
}

class MyApp extends StatelessWidget {
  final PostViewModel viewModel;

  const MyApp({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: MaterialApp(
        home: SinglePostPage(),
      ),
    );
  }
}
