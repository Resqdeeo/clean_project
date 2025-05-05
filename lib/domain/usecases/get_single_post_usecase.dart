import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetSinglePostUseCase {
  final PostRepository repository;

  GetSinglePostUseCase(this.repository);

  Future<Post> call(int id) => repository.getPost(id);
}
