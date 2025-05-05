import 'package:flutter/foundation.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_single_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';

class PostViewModel extends ChangeNotifier {
  final GetSinglePostUseCase getSinglePostUseCase;
  final GetPostsUseCase getPostsUseCase;

  PostViewModel(this.getSinglePostUseCase, this.getPostsUseCase);

  Post? post;
  List<Post> posts = [];
  bool isLoading = false;
  String? error;
  bool isEndReached = false;
  int currentPage = 1;

  Future<void> fetchPost() async {
    isLoading = true;
    notifyListeners();

    try {
      post = await getSinglePostUseCase(1);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPosts() async {
    if (isLoading || isEndReached) {
      // Если данные загружаются или конец списка, не запускаем новую загрузку (чисто для проверки)
      print('Пагинация остановлена: isLoading = $isLoading, isEndReached = $isEndReached');
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      // Посты для текущей страницы (для себя написал, чтоб видеть, что происходит)
      final newPosts = await getPostsUseCase(currentPage);
      print('Загружены новые посты: $newPosts');

      if (newPosts.isEmpty) {
        // Если постов больше нет, останавливаем пагинацию
        isEndReached = true;
        print('Посты закончились, пагинация завершена.');
      } else {
        posts.addAll(newPosts); // Добавляем новые посты в список
        currentPage++; // Переходим к следующей странице
      }
    } catch (e) {
      error = e.toString();
      print('Ошибка загрузки постов: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
