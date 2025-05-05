import '../entities/post.dart';

abstract class PostRepository {
  Future<Post> getPost(int id);
  Future<List<Post>> getPosts(int page, int limit); // метод для получения списка постов
}


