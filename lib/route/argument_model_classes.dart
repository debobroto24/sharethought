import '../core/controllers/auth/model/usermodel.dart';
import '../model/post_model.dart';

class CommentSectionArguments {
  final PostModel postModel;
  final UserModel userData;

  CommentSectionArguments({required this.postModel, required this.userData});
}