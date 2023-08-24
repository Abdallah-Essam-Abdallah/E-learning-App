import 'package:bloc/bloc.dart';
import 'package:courses_app/features/community/domain/entity/comment_entity.dart';
import 'package:courses_app/features/community/domain/entity/post_entity.dart';
import 'package:courses_app/features/community/domain/usecases/addcomment_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/addlike_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/addpost_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/getcomments_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/getposts_usecase.dart';
import 'package:courses_app/features/community/domain/usecases/upload_postimage_usecase.dart';
import 'package:equatable/equatable.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final AddPostUseCase addPostUseCase;
  final GetPostsUseCase getPostsUseCase;
  final AddLikeUseCase addLikeUseCase;
  final AddCommentUseCase addCommentUseCase;
  final UploadPostImageUsecase uploadPostImageUsecase;
  final GetCommentsUseCase getCommentsUseCase;
  String? image;
  List<CommentEntity> commentsList = [];
  bool isLiked = false;

  CommunityBloc({
    required this.addPostUseCase,
    required this.getPostsUseCase,
    required this.addLikeUseCase,
    required this.addCommentUseCase,
    required this.uploadPostImageUsecase,
    required this.getCommentsUseCase,
  }) : super(CommunityInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(AddPostloadingState());
      final result = await addPostUseCase.call(
          text: event.text,
          userName: event.userName,
          userImage: event.userImage,
          image: event.image ?? '');
      result.fold((faliure) => emit(AddPostErrorState(error: faliure.message)),
          (success) {
        emit(AddPostloadedState());
      });
    });

    on<UploadPostImageEvent>((event, emit) async {
      emit(UploadPostImageLoadingState());
      final result = await uploadPostImageUsecase.call();
      result.fold(
          (faliure) => emit(UploadPostImageErrorState(error: faliure.message)),
          (success) {
        image = success;
        emit(UploadPostImageLoadedState());
      });
    });

    on<GetPostsEvent>((event, emit) async {
      emit(GetPostsloadingState());
      final response = getPostsUseCase.call();
      await for (final posts in response) {
        emit(GetPostsloadedState(posts: posts));
      }
    });

    on<AddLikeEvent>((event, emit) async {
      emit(AddLikeloadingState());

      final result = await addLikeUseCase.call(post: event.post);
      result.fold((faliure) => emit(AddLikeErrorState(error: faliure.message)),
          (success) {
        emit(AddLikeloadedState());
      });
    });

    on<AddCommentEvent>((event, emit) async {
      emit(AddCommentloadingState());
      final result = await addCommentUseCase.call(
        postId: event.postId,
        userId: event.userId,
        commentingTime: event.commentingTime,
        text: event.text,
        userImage: event.userImage,
        userName: event.userName,
      );
      result
          .fold((faliure) => emit(AddCommentErrorState(error: faliure.message)),
              (success) {
        emit(AddCommentloadedState());
      });
    });

    on<GetCommentsEvent>((event, emit) async {
      emit(GetCommentsloadingState());
      final response = getCommentsUseCase.call(
        postId: event.postId,
      );
      await for (final comments in response) {
        commentsList = comments;
        emit(GetCommentsloadedState(comments: comments));
      }
    });
  }
}
