// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_project/main.dart';
import 'package:dio/dio.dart';
import 'package:clean_project/data/networks/api_service.dart';
import 'package:clean_project/data/repositories_impl/post_repository_impl.dart';
import 'package:clean_project/domain/usecases/get_single_post_usecase.dart';
import 'package:clean_project/domain/usecases/get_posts_usecase.dart';
import 'package:clean_project/presentation/viewmodels/post_viewmodel.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final dio = Dio();
    final apiService = ApiService(dio);
    final repository = PostRepositoryImpl(apiService);
    final getSinglePostUseCase = GetSinglePostUseCase(repository);
    final getPostsUseCase = GetPostsUseCase(repository);

    final postViewModel = PostViewModel(getSinglePostUseCase, getPostsUseCase);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(viewModel: postViewModel));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
