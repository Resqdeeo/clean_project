import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../networks/api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService api;

  PostRepositoryImpl(this.api);

  @override
  Future<Post> getPost(int id) async {
    final post = await api.getPost(id);
    return post;
  }

  @override
  Future<List<Post>> getPosts(int page, int limit) async {
    final postModels = await api.getPosts(page, limit); // получаем список постов с API
    return postModels.map((postModel) => Post(id: postModel.id, title: postModel.title, body: postModel.body)).toList();
  }
}
