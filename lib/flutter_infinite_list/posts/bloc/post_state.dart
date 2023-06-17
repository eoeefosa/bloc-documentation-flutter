part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? post,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: post ?? posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState {status: $status, hasReachedMax: $hasReachedMax, post: ${posts.length} }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, posts, hasReachedMax];
}
