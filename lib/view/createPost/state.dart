import 'package:sharethought/core/base_state/base_state.dart';

class CreatePostSuccessState extends SuccessState{
  final String text; 
  CreatePostSuccessState(this.text);
}

class CreatePostErrorState extends ErrorState{
  final String text; 
  CreatePostErrorState(this.text);
}